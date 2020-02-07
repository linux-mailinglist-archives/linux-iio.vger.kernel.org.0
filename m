Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6016315544E
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2020 10:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgBGJMO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Feb 2020 04:12:14 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:47094 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgBGJMO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Feb 2020 04:12:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id A9ABDFB03;
        Fri,  7 Feb 2020 10:12:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UkTU13E4jSmg; Fri,  7 Feb 2020 10:12:10 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id F13AA40756; Fri,  7 Feb 2020 10:12:09 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: vncl4000: Fix early return in vcnl4200_set_power_state
Date:   Fri,  7 Feb 2020 10:12:09 +0100
Message-Id: <19efdcd597b21ece9ad0ff894b6566d2ef4e2c02.1581066317.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Don't return early unconditionally.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

---
I've not added a 'Fixes:' line since this is not part of Linus tree yet.
Tested proximity and ambient light on a vcnl4040 and checked the driver
suspends/resumes correctly and puts out valid data right after resume.  

 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3b71c7d538af..38fcd9a26046 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -149,7 +149,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_data *data, bool on)
 	if (ret < 0)
 		return ret;
 
-	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, val);
 	if (ret < 0)
 		return ret;
 
-- 
2.23.0

