Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A09AAC607
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfIGKSa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 06:18:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfIGKSa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 06:18:30 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEFrX-1hybiC14Gz-00ADBm; Sat, 07 Sep 2019 12:18:05 +0200
Date:   Sat, 7 Sep 2019 12:18:00 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: hx711: optimize sampling of data
Message-ID: <20190907101759.kft6xwsqc5lf4acq@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:KJIq9yh7htm3z3TqDQtMtd3hM+vxzSn13L646XIZ12pFA1j0WCL
 UIXqB9Aj3j4Vc6wOASEHd4xNGoj9Z+g40aCMZmkSaCQumXKi1WYc6suRNBDQHA2r1btulbK
 FVgojmHPGlFFpLA11eqALXeMEsfoTmLArGj5mwybwvx2idFfZNEFZx27uCg9EXfq5Pytetx
 K8tyqqmenTMUqws2bkcTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n8ectdh0A8w=:HVEyY5JTyE/G/SPws61npV
 x160bt7BxVKOOncg4WjYzOQKKlZzfA8sq3N+uN3JIGrnTCg55oeL/dJBpRt7+xrSlzp43yjdy
 UCEodjvGkeKRpQFMichcmLx0wRSDqKL5QPYGLoXLWJWE71L98aiS1Nm64Q255biIbi/1f3tfH
 03XJLILeCx6y2i31aMU2sL0NbDc6AZSNGpa9PA9tqJp1IOXdDK3WTvTe6ySFgNH56x2wS8l7O
 uS6gaZ4h5eYMwV7xUFICeveTF00CImdbQ4I5rOdssPh4wLjxRg3m9CacfyTxquWVmnS+QQAvD
 /vRuPD9GLrvq7uEU0usUy64e8GHe6pdF83LNhfpa4HNYDLlogGmFhIA4HdWuAOBMMONsVBH6+
 0pLMzdBKNP2Op/+5sQJZnCt5ODS0lkbELISbl/WWFt2unLagJl84WYdZ6m3VhRb+5Z9SUzOXv
 fXxLoQlWxGIf78QkWnEBxlINb5FP4q/Ip1YVt1Qw5NmGt5MIAfoZxAp2xgeqXEMLlwzBw+uUT
 IahPDZlmLbcLOc5dhoiImOIRokbgVuZWvjQ930pJ88cWyRiuuiDchVEzshj0jkvpMpTAION2o
 ILLBpi1fJLTzvRDfRS1lkPDY8aspU5qw/BNbB4oHgSCpJ5wAanB5kw5XcuCx5xb9MlWsZQ2RW
 lzYEVlvPuqDAFy8kmUGu3BeAD5VTUkapelE2vI2IMS2YwoMBFiAfWuYuuFEXHhFiarRxYvMb7
 26ImWTJkzGap/cALUBuQvSvSReWQVKIdUV09Ct3/n1HgOEWO/kQh3eExAw4wjdTJtci7IEjGH
 VayIVRLUKLNKfrc8+ule7CCRUp3f4rIDE06ezN0GxmbzedjEIo=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix bug in sampling function hx711_cycle() when interrupt occures while
PD_SCK is high. If PD_SCK is high for at least 60 us power down mode of
the sensor is entered which in turn leads to a wrong measurement.

Move query of DOUT at the latest point of time which is at the end of
PD_SCK low period.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/hx711.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 88c7fe15003b..0678964dbd21 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -101,13 +101,14 @@ struct hx711_data {
 static int hx711_cycle(struct hx711_data *hx711_data)
 {
 	int val;
+	unsigned long flags;
 
 	/*
 	 * if preempted for more then 60us while PD_SCK is high:
 	 * hx711 is going in reset
 	 * ==> measuring is false
 	 */
-	preempt_disable();
+	local_irq_save(flags);
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
 
 	/*
@@ -117,7 +118,6 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	val = gpiod_get_value(hx711_data->gpiod_dout);
 	/*
 	 * here we are not waiting for 0.2 us as suggested by the datasheet,
 	 * because the oscilloscope showed in a test scenario
@@ -125,7 +125,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
 	 */
 	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
-	preempt_enable();
+	local_irq_restore(flags);
 
 	/*
 	 * make it a square wave for addressing cases with capacitance on
@@ -133,7 +133,8 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 	 */
 	ndelay(hx711_data->data_ready_delay_ns);
 
-	return val;
+	/* sample as late as possible */
+	return gpiod_get_value(hx711_data->gpiod_dout);
 }
 
 static int hx711_read(struct hx711_data *hx711_data)
-- 
2.13.3
