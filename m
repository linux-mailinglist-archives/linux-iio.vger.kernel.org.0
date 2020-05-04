Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8143F1C44E8
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgEDSLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 14:11:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732265AbgEDSLH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 14:11:07 -0400
Received: from localhost ([109.41.193.12]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M58SY-1jWm0f3tDQ-0016Pm; Mon, 04 May 2020 20:10:38 +0200
Date:   Mon, 4 May 2020 20:10:34 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        tglx@linutronix.de, allison@lohutok.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: bmp280: fix compensation of humidity
Message-ID: <20200504181033.GA15745@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:ocgTseaez8bdvV9u0+jmemzP2DfkQbD7gDGFoeFvrUSUgmWG2lK
 NDSVIRPPSrIMxBnpSWtJM8aYNFU5deDn9LaChONPne5226HYUGUW/wBhWBcvjvcH3hrwJM4
 byjq9YPVokkwr3qdK6wVvYmjbPxFLzqkAFb2DmAgHagi0pBcfXlkw+FH3c7Xmfiqwx3VMqY
 0zN7rp+/vM3yRtC2FsMiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lf9AWC4ovJ4=:mJnYAnWFsnpuNXC45ASvp/
 qHip1buxF0G2h4HS4JfGBUweYpiZNe8jidwQdTzAWFjLiMyEGBm3sb85PfrxTS3EG6sTNhSGi
 OYj7PPSl+wkzYUjUlKCNaQC37flFsYDO4hWR5e4hcTK/f9GAurjCqf2cWsyVabUuEyQrD7iSu
 Gi7+hHkbiJvHFZt/qGIqASEPrdMyA8mHeRMhyA4LwNNe/yNn8tBez/xjxiB1ouK8qM4zUURP0
 kAnmzqdDGIhGp1cc4pBcGpTweZ+EAtrPoUdBHKMHmh9MUGsIpLA/lw+3VYCH0N35KLTXeVaYt
 5ozXkao/PfDRz4zEpMjojmV9k7osfLLUzboF50WqwrxfJJa03R63AwPIbB1fIDrU3HUP8/2l6
 17FTxkz1oicJdVi7GmyGM4K36jQrxyAb+HtLMgwr8KELpbkVGIi7j73s7NfrmDu16rPmoyuYt
 EVRapTTULUDPV/1v/JpMQxOJ22aKkD1y6/E96OpD00UM2/UkGIioLa6z3sOluTM8KSDB1iOSO
 c+bX1lTOs2F9TUZmgOnWmSVSk07QG5c4GgBNih/wVFt7iQkdGMPRWLIYuxHYa2zsfCo6A+yT/
 XXptZRxZIAqV/Z4wTItCdn9RidsnlctQHwUg6pxy7Gznp4y1O9DQsFqkx4uuoioJE+KI2FNOc
 GFOOiRNeAyuFzc9t0Qrl7qNd5zFgUikGiJMkrUb02iGNLOjGCjgmqXlAcniyO5E4MwHvT+2d8
 B6Yz+vI4OobdHkwzFLOlweXKIgFM64CdeCPoegqJ0v5XhVd+WKhojm3ZHbEZxWMLdEAcgyMdw
 Hn7Q3zTDqNBtW0E0/hkEZQ/J06fGl64rVNtMTxrnnJBpRtWCR3uuf/VWZgMTzQ9UNP2fzyB
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Limit the output of humidity compensation to the range between 0 and 100
percent.

Depending on the calibration parameters of the individual sensor it
happens, that a humidity above 100 percent or below 0 percent is
calculated, which don't make sense in terms of relative humidity.

Add a clamp to the compensation formula as described in the datasheet of
the sensor in chapter 4.2.3.

Although this clamp is documented, it was never in the driver of the
kernel.

It depends on the circumstances (calibration parameters, temperature,
humidity) if one can see a value above 100 percent without the clamp.
The writer of this patch was working with this type of sensor without
noting this error. So it seems to be a rare event when this bug occures.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---

Change to v2:
Thanks to the review of Jonathan a more descriptive commit message is
added.

Change to v1:
Thanks to Tomasz for suggesting the easier to use function clamp_val()
which is now used.

 drivers/iio/pressure/bmp280-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 29c209cc1108..297ee2205bf6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -271,6 +271,8 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
 	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)calib->H1) >> 4;
 
+	var = clamp_val(var, 0, 419430400);
+
 	return var >> 12;
 };
 
-- 
2.20.1
