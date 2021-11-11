Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3390444D571
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhKKLDb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 06:03:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60590 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhKKLDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 06:03:31 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AB9U3fk002067;
        Thu, 11 Nov 2021 06:00:42 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c88pqepg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 06:00:41 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1ABB0eTB011741
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 06:00:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 11 Nov 2021
 06:00:39 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 11 Nov 2021 06:00:39 -0500
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ABB0cpi024606;
        Thu, 11 Nov 2021 06:00:39 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/1] LTC2688 support
Date:   Thu, 11 Nov 2021 12:00:42 +0100
Message-ID: <20211111110043.101891-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Pg760Wd_thonQ8PvmGkmaEJQsxZTiblz
X-Proofpoint-GUID: Pg760Wd_thonQ8PvmGkmaEJQsxZTiblz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The reason why this is a RFC is because I'm still waiting for proper HW
to test this thing. The reason why I'm sending this already is because
there's some non usual features which might require extra ABI. Hence,
while waiting I thought we could already speed up the process in regards
with the ABI.

I still pushed the driver but the intent here is not really to review it.
Naturally, if someone already wants to give some feedback, that's very
much appreciated :)

Now, there are three main interfaces depending on the channel mode:
 1) default (no new ABI)
 2) toggle mode
 3) dither mode

The channel mode will be a devicetree property as it does not really
make much sense to change between modes at runtime even more because the
piece of HW we might want to control with a channel might be different
depending on the selected mode (I'm fairly sure on this between toggle
and other modes but not so sure between dither and default mode).

toggle mode special ABI:

 * Toggle operation enables fast switching of a DAC output between two
different DAC codes without any SPI transaction. Two codes are set in
input_a and input_b and then the output switches according to an input
signal (input_a -> clk high; input_b -> clk low).

out_voltageY_input_register
 - selects between input_a and input_b. After selecting one register, we
   can write the dac code in out_voltageY_raw.
out_voltageY_toggle_en
 - Disable/Enable toggle mode. The reason why I think this one is
   important is because if we wanna change the 2 codes, we should first
   disable this, set the codes and only then enable the mode back...
   As I'm writing this, It kind of came to me that we can probably
   achieve this with out_voltageY_powerdown attr (maybe takes a bit more
   time to see the outputs but...) 

dither mode special ABI:

 * Dither operation adds a small sinusoidal wave to the digital DAC
signal path. Dithering is a signal processing technique that involves
the injection of ac noise to the signal path to reduce system
nonlinearities.

out_voltage0_dither_en
 - Same as in toggle mode.
out_voltage0_dither_period
out_voltage0_dither_phase
 - Period and phase of the signal. Only some values are valid so there's
   also *_available files for these. I'm not sure if we can use the more
   generic IIO_CHAN_INFO_PHASE and IIO_CHAN_INFO_FREQUENCY here as these
   parameters don't really apply to the channel output signal... 
out_voltage0_input_register
 - Same as in toggle mode. However in this mode the code set in the
   input_b register has a special meaning. It's the amplitude of the
   dither signal.

One special mention to the dac scale. In this part this is something
that can be purely controlled by SW so that I'm allowing userspace to
change it rather then having it in dts. The available scales are:

* [0 5V] -> offset 0
* [0 10V] -> offset 0
* [-5 5V] -> offset -32678
* [-10 10V] -> offset -32768
* [-15 15V] -> offset -32768

With the above, we also need to have the offset configurable and right
now I'm going to some trouble to make sure the scale + offset is
something valid. Honestly, I think I'm overdoing it because things can
still go wrong with [0 10V] and [-5 5V] as the scales are the same
here. Furthermore, there's no real arm that can be done to the HW. Is
just that the readings won't match with what someone might be expecting.
My plan is to just remove those checks and assume is up to userspace to
make it right and not have [-10 10V] scale with 0 offset for example.

I know that I'm taking a shortcut here :) so if you prefer to only
discuss this in the __real__ series, I totally get it.

https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2688.pdf

- Nuno Sá

Nuno Sá (1):
  iio: dac: add support for ltc2688

 drivers/iio/dac/ltc2688.c | 995 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 995 insertions(+)
 create mode 100644 drivers/iio/dac/ltc2688.c

-- 
2.33.1

