Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7242610EB67
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBON4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 09:13:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBON4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Dec 2019 09:13:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so44471815wrf.9
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2019 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1PMrn96rWUDDLi+Sy35n1PlzATfRqb610uo6W4mQjk=;
        b=X93yvQf21gMXFErsiS5HDL2vbn1oEpe8LRufvzTKW8aWCnduTqrKdSkF/7GyETqM+a
         KFTM/xJWFfU9hHVJhD+9TSqvEVIWEomTBW31YYMZea6tAlqkJJ39V1VTk4Injbn+fcS5
         dGfRx/qk2x0IchbEhY7M4KaIanwsfTaYAexkIlM9VMqmC3HqoSXJoCsnoPBDkLJ1ukp/
         n+y67nOfmn5JnW03ZmGLGiUx4HyS2yieZ4uQSXwCAZtvlv84Zc0aItfvDc9bae50Fpv/
         SAXnONzPZVpO/VapvzpsOSQ+uQTlz6TFniynLwA04KLy7EXQsCQ/to6U143YfmB+q0O9
         xF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1PMrn96rWUDDLi+Sy35n1PlzATfRqb610uo6W4mQjk=;
        b=RnDm5DryBkXb8201ZS/3kLy31HVgBpdqv7z7CWbIuPTQgtx+e0G91BgEJDlqx9GtNL
         BTpikTuQEpbQt9bGIX3HBy4gHIThPL0oVfxzFR30kOKuQ0VIWCL2lQ9SCdi+WpkySlGz
         xrvwdlALIgnRdWEqOX88RM+Q3Ixxf00SL2Vm3zHs9u48iCKH6Mnw+2co1bbCrKuByjEF
         PkjPNw+TwC3vQ6fb4uH7Trc+i1VHv1uvPBbYz60XuwV2xmXJ9wb4nebbAuYdjrZaGBQt
         /opcMymlJzxqi8pibldP/RmX7tn4OHr0ALMzyYioKZtVXW94Po7P+iJ/DVrfG1DYFaUR
         bw9w==
X-Gm-Message-State: APjAAAVGVubdLp8FGh+qxRn+gHjn7DCEqyVAhicFnTi0Ukodqm6s7W26
        vD+LT90errVJXpcS+kk4IEk=
X-Google-Smtp-Source: APXvYqzKoIE5mfPevYomt2naubgZqT2GtDspxpp1/J5FBavRzZ9N57+18MhHTmmJQTPEMkxqbTUP+w==
X-Received: by 2002:adf:db41:: with SMTP id f1mr8150114wrj.392.1575296032267;
        Mon, 02 Dec 2019 06:13:52 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.googlemail.com with ESMTPSA id x17sm18286010wrt.74.2019.12.02.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 06:13:51 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Couret Charles-Antoine <charles-antoine.couret@essensium.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [v2] iio: ad7949: fix channels mixups
Date:   Mon,  2 Dec 2019 15:13:36 +0100
Message-Id: <20191202141336.4507-1-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
References: <9ea595fc-d53b-3cd4-a511-db2b09726606@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Each time we need to read a sample (from the sysfs interface, since the
driver supports only it) the driver writes the configuration register
with the proper settings needed to perform the said read, then it runs
another xfer to actually read the resulting value. Most notably the
configuration register is updated to set the ADC internal MUX depending by
which channel the read targets.

Unfortunately this seems not enough to ensure correct operation because
the ADC works in a pipelined-like fashion and the new configuration isn't
applied in time.

The ADC alternates two phases: acquisition and conversion. During the
acquisition phase the ADC samples the analog signal in an internal
capacitor; in the conversion phase the ADC performs the actual analog to
digital conversion of the stored voltage. Note that of course the MUX
needs to be set to the proper channel when the acquisition phase is
performed.

Once the conversion phase has been completed, the device automatically
switches back to a new acquisition; on the other hand the device switches
from acquisition to conversion on the rising edge of SPI cs signal (that
is when the xfer finishes).

Only after both two phases have been completed (with the proper settings
already written in the configuration register since the beginning) it is
possible to read the outcome from SPI bus.

With the current driver implementation, we end up in the following
situation:

        _______  1st xfer ____________  2nd xfer ___________________
SPI cs..       \_________/            \_________/
SPI rd.. idle  |(val N-2)+    idle    | val N-1 +   idle ...
SPI wr.. idle  |  cfg N  +    idle    |   (X)   +   idle ...
------------------------ + -------------------- + ------------------
  AD  ..   acq  N-1      + cnv N-1 |  acq N     +  cnv N  | acq N+1

As shown in the diagram above, the value we read in the Nth read belongs
to configuration setting N-1.

In case the configuration is not changed (config[N] == config[N-1]), then
we still get correct data, but in case the configuration changes (i.e.
switching the MUX on another channel), we get wrong data (data from the
previously selected channel).

This patch fixes this by performing one more "dummy" transfer in order to
ending up in reading the data when it's really ready, as per the following
timing diagram.

        _______  1st xfer ____________  2nd xfer ___________  3rd xfer ___
SPI cs..       \_________/            \_________/           \_________/
SPI rd.. idle  |(val N-2)+    idle    |(val N-1)+    idle   |  val N  + ..
SPI wr.. idle  |  cfg N  +    idle    |   (X)   +    idle   |   (X)   + ..
------------------------ + -------------------- + ------------------- + --
  AD  ..   acq  N-1      + cnv N-1 |  acq N     +  cnv N  | acq N+1   | ..

NOTE: in the latter case (cfg changes), the acquisition phase for the
value to be read begins after the 1st xfer, that is after the read request
has been issued on sysfs. On the other hand, if the cfg doesn't change,
then we can refer to the fist diagram assuming N == (N - 1); the
acquisition phase _begins_ before the 1st xfer (potentially a lot of time
before the read has been issued via sysfs, but it _ends_ after the 1st
xfer, that is _after_ the read has started. This should guarantee a
reasonably fresh data, which value represents the voltage that the sampled
signal has after the read start or maybe just around it.

 Changes in V2
- Reword, with more detailed explanation
- Make the 3rd xfer conditional (only if prev cfg != new cfg)
- Clarify code comments

Cc: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc: Alexandru Ardelean <alexandru.Ardelean@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stefan Popa <stefan.popa@analog.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/adc/ad7949.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5c2b3446fa4a..2c6f60edb7ce 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -89,6 +89,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 				   unsigned int channel)
 {
 	int ret;
+	int i;
 	int bits_per_word = ad7949_adc->resolution;
 	int mask = GENMASK(ad7949_adc->resolution, 0);
 	struct spi_message msg;
@@ -100,12 +101,23 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 		},
 	};
 
-	ret = ad7949_spi_write_cfg(ad7949_adc,
-				   channel << AD7949_OFFSET_CHANNEL_SEL,
-				   AD7949_MASK_CHANNEL_SEL);
-	if (ret)
-		return ret;
+	/*
+	 * 1: write CFG for sample N and read old data (sample N-2)
+	 * 2: if CFG was not changed since sample N-1 then we'll get good data
+	 *    at the next xfer, so we bail out now, otherwise we write something
+	 *    and we read garbage (sample N-1 configuration).
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = ad7949_spi_write_cfg(ad7949_adc,
+					   channel << AD7949_OFFSET_CHANNEL_SEL,
+					   AD7949_MASK_CHANNEL_SEL);
+		if (ret)
+			return ret;
+		if (channel == ad7949_adc->current_channel)
+			break;
+	}
 
+	/* 3: write something and read actual data */
 	ad7949_adc->buffer = 0;
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
-- 
2.17.1

