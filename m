Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149EF1ED56C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 19:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFCRyX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFCRyX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 13:54:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF1C08C5C0;
        Wed,  3 Jun 2020 10:54:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 908822A3B0B
Subject: Re: [PATCHv2 0/7] Support inhibiting input devices
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        kernel@collabora.com, Peter Hutterer <peter.hutterer@redhat.com>,
        Benjamin Tissoires <btissoir@redhat.com>
References: <20200515164943.28480-1-andrzej.p@collabora.com>
 <842b95bb-8391-5806-fe65-be64b02de122@redhat.com>
 <e6030957-97dc-5b04-7855-bc14a78164c8@collabora.com>
 <6d9921fc-5c2f-beda-4dcd-66d6970a22fe@redhat.com>
 <09679de4-75d3-1f29-ec5f-8d42c84273dd@collabora.com>
 <f674ba4f-bd83-0877-c730-5dc6ea09ae4b@redhat.com>
 <2d224833-3a7e-bc7c-af15-1f803f466697@collabora.com>
 <aa2ce2ab-e5bc-9cb4-8b53-c1ef9348b646@redhat.com>
 <20200527063430.GJ89269@dtor-ws>
 <88f939cd-1518-d516-59f2-8f627a6a70d2@collabora.com>
 <20200602175241.GO89269@dtor-ws>
 <82e9f2ab-a16e-51ee-1413-bedf0122026a@collabora.com>
 <8f97d2e1-497a-495d-bc82-f46dbeba440c@redhat.com>
 <fb5bee72-6a75-88aa-8157-75f07c491eeb@collabora.com>
 <681abc14-ef0f-ff15-68ed-944b2f96bdaf@redhat.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <025361f4-5b1b-6669-ffa0-a6e8ad43940c@collabora.com>
Date:   Wed, 3 Jun 2020 19:54:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <681abc14-ef0f-ff15-68ed-944b2f96bdaf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

W dniu 03.06.2020 o 19:38, Hans de Goede pisze:
> Hi,
> 
> On 6/3/20 3:07 PM, Andrzej Pietrasiewicz wrote:
>> Hi Hans, hi Dmitry,
> 
> <snip>
> 
>> I'm taking one step back and looking at the ->open() and ->close()
>> driver callbacks. They are called from input_open_device() and
>> input_close_device(), respectively:
>>
>> input_open_device():
>> "This function should be called by input handlers when they
>> want to start receive events from given input device."
>>
>> ->open() callback:
>> "this method is called when the very first user calls
>> input_open_device(). The driver must prepare the device to start
>> generating events (start polling thread, request an IRQ, submit
>> URB, etc.)"
>>
>> input_close_device():
>> "This function should be called by input handlers when they
>> want to stop receive events from given input device."
>>
>> ->close() callback:
>> "this method is called when the very last user calls
>> input_close_device()"
>>
>> It seems to me that the callback names do not reflect their
>> purpose: their meaning is not to "open" or to "close" but to
>> give drivers a chance to control when they start or stop
>> providing events to the input core.
>>
>> What would you say about changing the callbacks' names?
>> I'd envsion: ->provide_events() instead of ->open() and
>> ->stop_events() instead of ->close(). Of course drivers can
>> exploit the fact of knowing that nobody wants any events
>> from them and do whatever they consider appropriate, for
>> example go into a low power mode - but the latter is beyond
>> the scope of the input subsystem and is driver-specific.
> 
> I don't have much of an opinion on changing the names,
> to me open/close have always means start/stop receiving
> events. This follows the everything is a file philosophy,
> e.g. you can also not really "open" a serial port,
> yet opening /dev/ttyS0 will activate the receive IRQ
> of the UART, etc. So maybe we just need to make the
> docs clearer rather then do the rename?  Doing the
> rename is certainly going to cause a lot of churn.

Right, I can see now that the suggestion to change names is
too far fetched. (I feel that release() would be better
than close(), though). But it exposes the message I wanted to
pass.

> 
> Anyways as said, I don't have much of an opinion,
> so I'll leave commenting (more) on this to Dmitry.
> 
>> With such a naming change in mind let's consider inhibiting.
>> We want to be able to control when to disregard events from
>> a given device. It makes sense to do it at device level, otherwise
>> such an operation would have to be invoked in all associated
>> handlers (those that have an open handle associating them with
>> the device in question). But of course we can do better than
>> merely ignoring the events received: we can tell the drivers
>> that we don't want any events from them, and later, at uninhibit
>> time, tell them to start providing the events again. Conceptually,
>> the two operations (provide or don't provide envents) are exactly
>> the same thing we want to be happening at input_open_device() and
>> input_close_device() time. To me, changing the names of
>> ->open() and ->close() exposes this fact very well.
>>
>> Consequently, ->inhibit() and ->uninhibit() won't be needed,
>> and drivers which already implement ->provide_events() (formerly
>> ->open()) and ->stop_events() (formerly ->close()) will receive
>> full inhibit/uninhibit support for free (subject to how well they
>> implement ->provide_events()/->stop_events()). Unless we can come
>> up with what the drivers might be doing on top of ->stop_events()
>> and ->provide_events() when inhibiting/uninhibiting, but it seems
>> to me we can't. Can we?
> 
> Right. I'm happy that you've come to see that both on open/close
> and on inhibit/uninhibit we want to "start receiving events" and
> "stop receiving events", so that we only need one set of callbacks.
> 

Yeah, that's my conclusion - at least on a conceptual level.

That said, what I can imagine is an existing driver (e.g. elan_i2c)
which does not implement neither open() nor close(), but does have
suspend() and resume(). Then it is maybe a bit easier to add inhibit()
and uninhibit() /they would be similar to suspend and resume/ instead
of open() and close(): If only open() and close() are possible, then
the probe function needs to be extended to "close" the device before it
gets registered, because from the moment it is registered it might be
opened right away. And the device must be available earlier during the
course of probe to query some parameters through i2c:

+static int elan_reactivate(struct elan_tp_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int ret;
+
+	ret = elan_enable_power(data);
+	if (ret)
+		dev_err(dev, "failed to restore power: %d\n", ret);
+
+	ret = elan_initialize(data);
+	if (ret)
+		dev_err(dev, "failed to re-initialize touchpad: %d\n", ret);
+
+	return ret;
+}
+
+static int elan_open(struct input_dev *input)
+{
+	struct elan_tp_data *data = input_get_drvdata(input);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	dev_dbg(&client->dev, "uninhibiting\n");
+
+	ret = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (ret)
+		return ret;
+
+	ret = elan_reactivate(data);
+	if (ret == 0)
+		enable_irq(client->irq);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+	return ret;
+}
+
+static int elan_inhibit(struct input_dev *input)
+{
+	struct elan_tp_data *data = input_get_drvdata(input);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	dev_dbg(&client->dev, "closing\n");
+
+	/*
+	 * We are taking the mutex to make sure sysfs operations are
+	 * complete before we attempt to bring the device into low[er]
+	 * power mode.
+	 */
+	ret = mutex_lock_interruptible(&data->sysfs_mutex);
+	if (ret)
+		return ret;
+
+	disable_irq(client->irq);
+
+	ret = elan_disable_power(data);
+	if (ret)
+		enable_irq(client->irq);
+
+	mutex_unlock(&data->sysfs_mutex);
+
+	return ret;
+}
+
+static void elan_close(struct input_dev *input)
+{
+	elan_inhibit(input);
+}
+
  static int elan_query_device_info(struct elan_tp_data *data)
  {
  	int error;
  	u16 ic_type;

  	error = data->ops->get_version(data->client, false, &data->fw_version);
  	if (error)
  		return error;

  	error = data->ops->get_checksum(data->client, false,
  					&data->fw_checksum);
  	if (error)
  		return error;

  	error = data->ops->get_version(data->client, true, &data->iap_version);
  	if (error)
  		return error;
@@ -1071,34 +1141,36 @@ static int elan_setup_trackpoint_input_device(struct 
elan_tp_data *data)

  static int elan_setup_input_device(struct elan_tp_data *data)
  {
  	struct device *dev = &data->client->dev;
  	struct input_dev *input;
  	unsigned int max_width = max(data->width_x, data->width_y);
  	unsigned int min_width = min(data->width_x, data->width_y);
  	int error;

  	input = devm_input_allocate_device(dev);
  	if (!input)
  		return -ENOMEM;

  	input->name = "Elan Touchpad";
  	input->id.bustype = BUS_I2C;
  	input->id.vendor = ELAN_VENDOR_ID;
  	input->id.product = data->product_id;
+	input->open = elan_open;
+	input->close = elan_close;
  	input_set_drvdata(input, data);

  	error = input_mt_init_slots(input, ETP_MAX_FINGERS,
  				    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED);
  	if (error) {
  		dev_err(dev, "failed to initialize MT slots: %d\n", error);
  		return error;
  	}

  	__set_bit(EV_ABS, input->evbit);
  	__set_bit(INPUT_PROP_POINTER, input->propbit);
  	if (data->clickpad) {
  		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
  	} else {
  		__set_bit(BTN_RIGHT, input->keybit);
  		if (data->middle_button)
  			__set_bit(BTN_MIDDLE, input->keybit);
@@ -1253,34 +1325,40 @@ static int elan_probe(struct i2c_client *client,
  	if (!irqflags)
  		irqflags = IRQF_TRIGGER_FALLING;

  	error = devm_request_threaded_irq(dev, client->irq, NULL, elan_isr,
  					  irqflags | IRQF_ONESHOT,
  					  client->name, data);
  	if (error) {
  		dev_err(dev, "cannot register irq=%d\n", client->irq);
  		return error;
  	}

  	error = devm_device_add_groups(dev, elan_sysfs_groups);
  	if (error) {
  		dev_err(dev, "failed to create sysfs attributes: %d\n", error);
  		return error;
  	}

+	error = elan_inhibit(data->input);
+	if (error) {
+		dev_err(dev, "failed to inhibit input device before registering: %d\n", error);
+		return error;
+	}
+
  	error = input_register_device(data->input);
  	if (error) {
  		dev_err(dev, "failed to register input device: %d\n", error);
  		return error;
  	}

  	if (data->tp_input) {
  		error = input_register_device(data->tp_input);
  		if (error) {
  			dev_err(&client->dev,
  				"failed to register TrackPoint input device: %d\n",
  				error);
  			return error;
  		}
  	}

  	/*
@@ -1294,72 +1372,71 @@ static int elan_probe(struct i2c_client *client,
  }

  static int __maybe_unused elan_suspend(struct device *dev)
  {
  	struct i2c_client *client = to_i2c_client(dev);
  	struct elan_tp_data *data = i2c_get_clientdata(client);
  	int ret;

  	/*
  	 * We are taking the mutex to make sure sysfs operations are
  	 * complete before we attempt to bring the device into low[er]
  	 * power mode.
  	 */
  	ret = mutex_lock_interruptible(&data->sysfs_mutex);
  	if (ret)
  		return ret;

-	disable_irq(client->irq);
+	mutex_lock(&data->input->mutex);
+	if (input_device_enabled(data->input)) {
+		disable_irq(client->irq);

-	if (device_may_wakeup(dev)) {
-		ret = elan_sleep(data);
-		/* Enable wake from IRQ */
-		data->irq_wake = (enable_irq_wake(client->irq) == 0);
-	} else {
-		ret = elan_disable_power(data);
+		if (device_may_wakeup(dev)) {
+			ret = elan_sleep(data);
+			/* Enable wake from IRQ */
+			data->irq_wake = (enable_irq_wake(client->irq) == 0);
+		} else {
+			ret = elan_disable_power(data);
+		}
  	}
+	mutex_unlock(&data->input->mutex);

  	mutex_unlock(&data->sysfs_mutex);
  	return ret;
  }

  static int __maybe_unused elan_resume(struct device *dev)
  {
  	struct i2c_client *client = to_i2c_client(dev);
  	struct elan_tp_data *data = i2c_get_clientdata(client);
-	int error;
+	int ret = 0;

-	if (device_may_wakeup(dev) && data->irq_wake) {
-		disable_irq_wake(client->irq);
-		data->irq_wake = false;
-	}
+	mutex_lock(&data->input->mutex);
+	if (input_device_enabled(data->input)) {
+		if (data->irq_wake) {
+			disable_irq_wake(client->irq);
+			data->irq_wake = false;
+		}

-	error = elan_enable_power(data);
-	if (error) {
-		dev_err(dev, "power up when resuming failed: %d\n", error);
-		goto err;
+		ret = elan_reactivate(data);
+		enable_irq(data->client->irq);
  	}
+	mutex_unlock(&data->input->mutex);

-	error = elan_initialize(data);
-	if (error)
-		dev_err(dev, "initialize when resuming failed: %d\n", error);
-
-err:
-	enable_irq(data->client->irq);
-	return error;
+	return ret;
  }

Regards,

Andrzej
