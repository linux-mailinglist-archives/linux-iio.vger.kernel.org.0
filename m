Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04E61BA59B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0OA7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 10:00:59 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgD0OAw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 10:00:52 -0400
Received: from localhost ([109.41.194.26]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6sON-1j7g1g0Aed-018Lsx; Mon, 27 Apr 2020 16:00:23 +0200
Date:   Mon, 27 Apr 2020 16:00:19 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        tglx@linutronix.de, allison@lohutok.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: bmp280: fix compensation of humidity
Message-ID: <20200427140017.GA25402@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:tcKH7nPEyKfMcDD2F9kaxMB5SlaQQyO81sdZWyfprhBwlc8BRZ5
 CKn9SjH/HoNL2EiXPUG0olFXqFqTpIwnBQHI/cXeAGrTHFuSowrGcAatD7uiz1p9jVVuCQV
 BztvGLp6CEf5KXe6caXnuertc2S4mNiY8Rri/OhNLfzVIUrPpfEqX5AysUIfY8k3sSYe3AY
 k75pwe3lujqHkt3NSdGhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MhHVfASsqnE=:oA/7DL60ewl/0B+eL9FqNa
 21qi8f6W/DmlH1ebuMABZsQtGM/+PCyRbJO4VT8boGgPrAiOm7tigdBJLxBxyqcagNA/ocHdz
 HuE1aDm7gsaIC6HaBlY+jYtkxdLpf7kFU6x4S2MKK14IiKEbNMbvIv3W2Z1aa6w+/BJhiSibC
 AB5PGrlwHehYSCXjV40QtRo6QF/4iaLBWhauCqmkZ2/fLp2IccWNmA/nc3Bld0GGL+pRcS6dn
 bh+1FRo1ejHhpu7Z6GnMJGTIfaXIKPziL4Ih2gcaVswzbeBdhx0BBGFSGNJxgGD9+prZ4w8h7
 w1q4otzUD3kFi+DCwo+hxUd5RWLoWWqRFE42KS99yVHIcmemq1Rlvj00t0hCgRjMYQTmfFudL
 TDb7S2lhJSa3alkf7T6v4sH85E3K6g2AaoScS4rb4kxxHrv0QC76LM0V1XBg/9devS5kA1/8K
 /8fpjOe6ucadozFs4D1Rb7KUjh7+1UX6HbuKyPp9x2oxcb2Tm+Ut1Rin49Xoz4SwfgtXmw/s9
 vHvhvHO4pu5oLgupYXCvvC0+R+/HMONg+Jl35NUP/JZ0p9Fdy+0ABkUT9HuJtE51fzTj9dgc3
 HHR5QBAFRt1mqLCNbMpnGvupvCctccZZj/Fe23FcE0kyiUDVW1lrP0CJTIuCUnS3H55NB+crK
 SGUAc/T7B0+WAvqY8+TYXbzLoCwtDmaZTAGIN56huUkiPinndGdaQ+lhyAyym+VufAZujszyS
 X5GBAchc+kWxtaU32KQCszQ+QoBGS58LE1xlf6cVMSdZWIf4/8hdJSbPcVpHqGPeD88euZHwk
 hsgpcBnRKgH2aPcLcU/Vb1yC2YEm+rOaBZkoMvVc6u89yzMbhY/ZbgpyhA6J2U87LY3dKHx
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Output of humidity compensation is limited to the range between 0 and 100
percent. Add this to the compensation formula as described in the datasheet
chapter 4.2.3.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/pressure/bmp280-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29c209cc1108..ac9ef1b63b07 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -271,6 +271,9 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
 	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
 
+	var = var < 0 ? 0 : var;
+	var = var > 419430400 ? 419430400 : var;
+
 	return var >> 12;
 };
 
-- 
2.20.1
