Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E5AAD92A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfIIMic (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:38:32 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfIIMib (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 08:38:31 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsqMq-1iRBEX2R1k-00tA70; Mon, 09 Sep 2019 14:38:09 +0200
Date:   Mon, 9 Sep 2019 14:38:08 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: adc: hx711: remove unnecessary returns
Message-ID: <20190909123806.ewrxc7y5gmh5plmk@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:sYDxRPyTH6C963S9/gAb7OfPBbNXhNeJ1VYf7nec78X5l8tEuYz
 89GJ3GsRA3UGY+lHLXgvDVrblbvhsuMpk3tdhjGV9YYmscCDr8C/3RS7cLhaMzcg0CrVjU3
 1oHubHyyDAvunKH+hjjY1KGERUiW3P7AOfzdjn7CpafTqTJMUl4h82npocnVxPkqQ/cNkQm
 v8N1sbOksdpuhhrvbnr0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D1A/xcjwmhE=:2hJiZpX/Ug+t4LH3e2ULTW
 QW6BrjPYoO7hKtZuenuHvoBcsy6l9Bpwf4CW4ZlBjTUr+JVP+jcCHzQZjEmEPFtASvjAq8o7r
 pvR3Z5Ts93bNTsbC0sfIE3KQs2tN5w1xTyOSG19Tj0D3/VBEXTcBXYt190/gzElSbNxrVP7dE
 C/Xf5o5HviXcVwknJWXeZHKuDaIihd+BO4E/1vx6Sc5Y0lN6X5gG+3/6vfvJPmOB6+h01rcnN
 1bH3MZIUM/RJKMGS/+4YQ3RtepBvxIxc4yhYNRJqigcH5d9ZvvOPNAPzGog+6HDAJyCe4+LKo
 vZJgs5MHfC219paPDGIdsto6xdx/KB3UtknvevYtSw0khpt/mZtHNSr635sOAYIVqNp8B8xBi
 sGWzdDO2eCGczM8U2i62u2olujLErvkTf9/A+LVEfYfsLHNKdnrKc9hxpQMUumHVvQ1Z9PpNb
 7hXdmk9SrHu9wfOcYWHvO2+jR/u7Z2K7/LFgUI3nT8ev74Sh0oAXaD9M7FS4PU+V48f5i1I98
 HVukkycewsEv07Reh34/BBZ/F//TLPzFzX3oP2p2CQ91Nc4eNvZtz3YndLwuJVhOkrxhX2Iif
 IAgYg6ktZRYEEcoJVMMa6xqUt6QbnBjgCKpHLN0obphipe1eDX6R8xOyg4gHAHHVjuUpO0zZH
 seH3ZSUkw/eNtamEzfH1x0FvObNIuoxRTiDau171iIE+8UOHKQQYCayTfWM1OvDjEdFVX/EXM
 b/u71vAG3p48x7mEfIlzH99dF39Iv8fJ3Pztck/mtc2RpGiKoieeFX9gcEzujGG/FJLhgO+d8
 4RI6bWnX0LYYSWPrTosoAxaS4yxLQ==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Optimize use of return in hx711_set_gain_for_channel().

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index c8686558429b..20c249f502c0 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -213,7 +213,7 @@ static int hx711_reset(struct hx711_data *hx711_data)
 
 static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 {
-	int ret;
+	int ret = 0;
 
 	if (chan == 0) {
 		if (hx711_data->gain_set == 32) {
@@ -224,8 +224,6 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 				return ret;
 
 			ret = hx711_wait_for_ready(hx711_data);
-			if (ret)
-				return ret;
 		}
 	} else {
 		if (hx711_data->gain_set != 32) {
@@ -236,12 +234,10 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 				return ret;
 
 			ret = hx711_wait_for_ready(hx711_data);
-			if (ret)
-				return ret;
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
-- 
2.11.0
