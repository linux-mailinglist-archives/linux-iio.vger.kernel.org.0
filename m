Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9584B19E4F1
	for <lists+linux-iio@lfdr.de>; Sat,  4 Apr 2020 14:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDMnH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 4 Apr 2020 08:43:07 -0400
Received: from relay-2.mailobj.net ([213.182.54.5]:51991 "EHLO
        relay-2.mailobj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDDMnH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Apr 2020 08:43:07 -0400
Received: from www-2.localdomain (www-2.in.mailobj.net [192.168.90.194])
        by relay-2.mailobj.net (Postfix) with SMTP id DCCAC13B9;
        Sat,  4 Apr 2020 14:43:04 +0200 (CEST)
Received: by www-2.mailo.com with http webmail; Sat,  4 Apr 2020
  14:43:04 +0200 (CEST)
X-EA-Auth: C740K8/jcAGq1iPjVma90pf9nhM772y1Jad28paqpdvZoYR1+bPkviuJRHHHiINwkfjl0DRV7SI+oDwAKhaIHn69pZ9hHlUs
From:   yarl-baudig@mailoo.org
To:     denis.ciocca@st.com, linux-iio@vger.kernel.org
Date:   Sat,  4 Apr 2020 14:43:04 +0200 (CEST)
Subject: lsm303dlhc magnetometer: please help
X-Priority: 3
MIME-Version: 1.0
X-Mailer: COMS/EA19.11/r20200317
Message-ID: <ea-mime-5e8880d8-2b90-69383931@www-2.mailo.com>
Content-Type: text/plain;
 charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Good afternoun,

I have an lsm303dlhc that I'm trying to get to work with a triggered buffer, the magnetometer part of it.
The problem with this sensor is that the dataready signal has, I think, a different
meaning than the one expected by the ST sensor driver set.
On this sensor the signal is always high except when the sensor is writing new values to its data
registers. The problem with the driver is that it expects the sensor to have a register
to check if new data is available:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?h=testing#n36
the lsm303dlhc magnetometer is not configured with such a register:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/magnetometer/st_magn_core.c?h=testing#n183
There is one in the sensor but the dataready bit is just the value of the signal, so,
even if I added the address and mask for this information, the meaning would be
wrong from the point of view of  function and the while loop would run endlessly:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/common/st_sensors/st_sensors_trigger.c?h=testing#n113

I then modified a bit, patch below.

Let me first tell you that it work one out of two time:
I boot, load this device-tree:
---
/dts-v1/;
/plugin/;

/ {
  compatible = "brcm,bcm2708";

  fragment@0 {
    target = <&gpio>;
    __overlay__ {
      magn_pins: nine_dof_pins {
        brcm,pins = <27>;
        brcm,function = <0>;
        brcm,pull = <1>;
        status = "okay";
      };
    };
  };

  fragment@1 {
    target = <&i2c_arm>;
    __overlay__ {
      status = "okay";
      #address-cells = <1>;
      #size-cells = <0>;
      magn@1e {
        compatible = "st,lsm303dlhc-magn";
        reg = <0x1e>;
        status = "okay";
        interrupt-parent = <&gpio>;
        interrupts = <27 1>;
      };
    };
  };
};
---
I then enable scan_elements, enable buffer (echo 1 > buffer/enable)
interrupts are coming regularly at sampling_frequency. It works fine.
If I now disable the buffer then re-enable it, one and only interrupt,
doesn't work fine..
re-disable, re-re-enable: works fine!
and it seem to be always that, it works modulo 2.

On my first try I didn't change st_magn_buffer_preenable and st_magn_buffer_postenable
But I thought that maybe, the problem was some sort of bad writting, reading timing
because 
(1) request_threaded_irq is called for a rising signal while it is already high.

I make a break here and ask you a question:
As you read, I am a kernel newbie: is doing (1) bad?
end of break.

So I added st_magn_buffer_preenable and modified st_magn_buffer_postenable to
try to mask the irq during the arppropriate interval.

No visible change.
I never almost never wrote kernel code before.
I tried to get closer to what was happening using gdb/kgdb, first time I used this.
I am now pretty discouraged and any suggestions are welcome.

Thank you.

---
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 +++++++++++
 .../iio/common/st_sensors/st_sensors_trigger.c  |  9 +++++++++
 drivers/iio/magnetometer/st_magn_buffer.c       | 17 ++++++++++++++++-
 drivers/iio/magnetometer/st_magn_core.c         |  3 +++
 include/linux/iio/common/st_sensors.h           |  2 ++
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 09279e40c55c..fef6b70976b4 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -480,6 +480,17 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 	u8 drdy_addr, drdy_mask;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
+	if (sdata->sensor_settings->drdy_irq.simple) {
+		/*
+		 * some devices very simple. No register to enable, disable
+		 * or configure the signal. Actually, when it is low it means that
+		 * sensor is writing data to its register, when it is high it
+		 * means that data can be read. i.e when rising new data is available.
+		 */
+		sdata->hw_irq_trigger = enable;
+		return 0;
+	}
+
 	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
 	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		/*
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index fdcc5a891958..146aaae0a85c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -30,6 +30,13 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
 	u8 status;
 	int ret;
 
+	/* We simply trust the signal */
+	if (sdata->sensor_settings->drdy_irq.simple) {
+		if (indio_dev->active_scan_mask)
+			return 1;
+		return 0;
+	}
+
 	/* How would I know if I can't check it? */
 	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
 		return -EINVAL;
@@ -90,6 +97,8 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
 	if (sdata->hw_irq_trigger &&
 	    st_sensors_new_samples_available(indio_dev, sdata)) {
 		iio_trigger_poll_chained(p);
+		if (sdata->sensor_settings->drdy_irq.simple)
+			return IRQ_HANDLED;
 	} else {
 		dev_dbg(sdata->dev, "spurious IRQ\n");
 		return IRQ_NONE;
diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 37ab30566464..ae13e4339127 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -30,6 +30,16 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
 	return st_sensors_set_dataready_irq(indio_dev, state);
 }
 
+static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct st_sensor_data *mdata = iio_priv(indio_dev);
+
+	if (mdata->sensor_settings->drdy_irq.simple) {
+		disable_irq(mdata->get_irq_data_ready(indio_dev));
+	}
+	return 0;
+}
+
 static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 {
 	int err;
@@ -45,7 +55,11 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_buffer_postenable_error;
 
-	return st_sensors_set_enable(indio_dev, true);
+	err = st_sensors_set_enable(indio_dev, true);
+
+	enable_irq(mdata->get_irq_data_ready(indio_dev));
+
+	return err;
 
 st_magn_buffer_postenable_error:
 	kfree(mdata->buffer_data);
@@ -70,6 +84,7 @@ static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
+	.preenable = &st_magn_buffer_preenable,
 	.postenable = &st_magn_buffer_postenable,
 	.predisable = &st_magn_buffer_predisable,
 };
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 72f6d1335a04..0fb0915529e9 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -259,6 +259,9 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 				},
 			},
 		},
+    .drdy_irq = {
+      .simple = true,
+    },
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f9bd6e8ab138..e25b5f033557 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -154,6 +154,7 @@ struct st_sensor_int_drdy {
  * struct ig1 - represents the Interrupt Generator 1 of sensors.
  * @en_addr: address of the enable ig1 register.
  * @en_mask: mask to write the on/off value for enable.
+ * @simple: the data-ready is a "very simple implementation".
  */
 struct st_sensor_data_ready_irq {
 	struct st_sensor_int_drdy int1;
@@ -168,6 +169,7 @@ struct st_sensor_data_ready_irq {
 		u8 en_addr;
 		u8 en_mask;
 	} ig1;
+	bool simple;
 };


