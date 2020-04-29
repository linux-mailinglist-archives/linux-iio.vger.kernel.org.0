Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3C1BE698
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 20:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2StW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 14:49:22 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:45853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2StW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 14:49:22 -0400
Received: from localhost ([109.41.192.52]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAgMY-1jItPe1mtU-00B39G; Wed, 29 Apr 2020 20:48:58 +0200
Date:   Wed, 29 Apr 2020 20:48:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        tglx@linutronix.de, allison@lohutok.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: bmp280: fix compensation of humidity
Message-ID: <20200429184852.GA17547@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:AdbQLe8B4HsYrW02JRaow2+X0OO3gZNqUU2fAlkjX+E5s3Dp9q/
 rkQ4DdHXGAApZKu8JJPKiH1Z3HZJ4F2kxUpLoLKiIgcuh2FsrQ20oCmZRr2593jKE+Y4UHP
 3y8spH5ReJudrTxi5vsbVPPDqnt7+fjQ44zlZZfh6CRMweIkd/mT9bs2gWqQ80zkrnpLBOZ
 gecZ71znEc1WIoKsAE0tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IrgSeIFd9j0=:Z+sIHlvIHx2rwR/qOB+XVF
 W3hZC54vEBO2QtjzQPdHPaV/UmfF0rgHQPkaUwFGG4mTP48G93RCbf3CNHI6o41aH3VjN+/MX
 XSUxBhIkuNeuTiL3sHH6nSneDrhMOhD1SdmzrAI1hBAeY4LkiJzEehTdRAp/s0hvBFkG1u7yZ
 iMU/IpmwbARwKFwI85S1QGuT0NSNE/eVhonMdK603PA3KQY+r7VzdUJC4fYF5W329zEQYUJsB
 YnNiS6/7guP0HAqiI4/hNCg78Jm0IiEkhRcq4KqBAFMKpSRbMKHU/5pxbAMW6RkCn5PlAytNN
 a6PChL+hUCbpKqiJXVCQQuPoeyy7O5wPUnCw/fCWFhsg21Zh3kY5mS+NqsSsSwm4N2h/zMjyU
 pZ6R9AgLovAbvZosgVIAgIk7VeIpP/8OpqKlM97wTN+hm8crnZPdeNP9E0XfzypnCPwZ8af5C
 nCUbTQFLjLY56FtrCfketKlETMivMCvQ+VuU9QyvQgBHGfgjfsgHMNRn/hRKxm5XLh13HvlAV
 /Ji3k2dQcUDd7XtMUkKofZ0iDsBYnv3gXLwhlfuv07umYQugwznbj8qGUJyFri9hd7Z/jZ7JK
 4BJdK8gU78EI0pBPmxrxdM/XAiZIvJcvzUpPSRTBbHBw4bnYBlvTMI7ReSjZjOptKmyg0wADi
 tWU80C/EW8qvXNof9VmSCHhx50bXIN0WeTLFA1psFYGmpKGsCroZQHHD9YPVv3ANYYQ/S0YbO
 0JJYWxh8s5a0u+Ryk9kcZ4SnKPwC5y+BkIXu8HiatV8Ott81zbb1wUS+6rglMBUwOXxSSLoq4
 xJI70s9JAEUbBrsfGvAIWkKwYpImzLsB1QBAco42Plk8iOtnN6U23TulG7J3z5hr6iEkdsW
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Output of humidity compensation is limited to the range between 0 and
100 percent. Add this to the compensation formula as described in the
datasheet chapter 4.2.3.

Change to v1:
Thanks to Tomasz for suggesting the easier to use function clamp_val()
which is now used.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
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
