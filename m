Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFE477038E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Aug 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjHDOvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Aug 2023 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjHDOvX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Aug 2023 10:51:23 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A274749E0
        for <linux-iio@vger.kernel.org>; Fri,  4 Aug 2023 07:51:22 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 374CF3tX028158;
        Fri, 4 Aug 2023 10:51:19 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3s8qabv3v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 10:51:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 374EpIs0005019
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 10:51:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Aug 2023
 10:51:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Aug 2023 10:51:17 -0400
Received: from nsa.sphairon.box ([10.44.3.51])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 374Ep87g010508;
        Fri, 4 Aug 2023 10:51:10 -0400
From:   Nuno Sa <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/3] Add converter framework
Date:   Fri, 4 Aug 2023 16:53:38 +0200
Message-ID: <20230804145342.1600136-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 84ywc7cLMeaqtRf9WERgJqAB4A6zw0RW
X-Proofpoint-GUID: 84ywc7cLMeaqtRf9WERgJqAB4A6zw0RW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308040133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is the initial RFC following the discussion in [1]. I'm aware this is
by no means ready for inclusion and it's not even compilable since in
the RFC I did not included the patch to add component_compare_fwnode()
and component_release_fwnode(). 

The goal is to have a first feel on the
direction of the framework so that if I  need to drastically change it,
better do it now. The RFC also brings the ad9647 and the axi_adc core to
the same functionality we have now upstream with one extra fundamental
feature that is calibrating the digital interface. This would be very
difficult to do with the current design. Note that I don't expect any
review on those drivers (rather than things related to the framework). 

I also want to bring up a couple of things that I've
been thinking that I'm yet not sure about (so some feedback might make
mind in one direction or another).

1) Im yet not sure if I should have different compatibles in the
axi-adc-core driver. Note this soft core is a generic core and for every
design (where the frontend device changes or has subtle changes like
different number of data paths) there are subtle changes. So, the number
of channels might be different, the available test patterns might be
different, some ops might be available for some designs but not for
others, etc... With a different compatible we could fine tune
those differences (with a chip_info like structure) and pass some const
converter_config to the framework that would allow it to do more safety
checks and potentially reduce the number of converter_ops.
OTOH, starting to add all of these compatibles might become messy in the
long run and will likely mean that we'll always have to change both
drivers in order to support a new frontend. And the frontend devices
should really be the ones having all the "knowledge" to configure the
soft core even if it means more converter_ops (though devicetree might
help as some features are really HW dependent). I more inclined to just
leave things as-is in the RFC.

2) There are some IIO attributes (like scale, frequency, etc) that might
be implemented in the soft cores. I still didn't made my mind if I should just
have a catch all read_raw() and write_raw() converter_ops or more fine
tuned ops. Having the catch all reduces the number of ops but also makes
it more easier to add stuff that ends up being not used anymore and then
forgotten. There are also cases (eg: setting sampling frequency) where
we might need to apply settings in both the frontend and the backend
devices which means having the catch all write_raw() would be more
awkward in these case. I'm a bit more inclined to the more specific ops. 

3) I also placed this in addac as this is mostly used in high speed DACs
and ADCs but maybe we should just have it in the top level directory
just in case this is started to be used in different type of devices?

4) Some function and data names are also starting to become very big so
if there are no objections I will move all to use conv instead of full
converter. Or maybe something a bit more generic (converter is a bit specific
I know)?

I would love to hear some ideas about the above...

Anyways, I should also mention that the only visible ABI breakage is in
the IIO device name. Before it was named "adi-axi-adc" and now it's
"ad9647" which is what makes sense actually. With the current approach
we would not be able to actually distinguish between designs. 

So my plan for the actual series will be to just add the framework and migrate
the current drivers to it with the same functionality as they have now (not
sure if it will be viable to migrate the drivers in a way each commit is
functional - unless we convert both drivers in one commit). After that
point, I will start adding all the missing features (and devices) to the
ad9467 driver. To note that I also plan to include the axi-dac driver in
the first series and that will require IIO DMA output buffer support
so we might need to cherry-pick those patches from Paul's DMABUF series.

Thanks!
- Nuno Sá

[1]: https://lore.kernel.org/linux-iio/dac3967805d7ddbd4653ead6d50e614844e0b70b.camel@gmail.com/

Nuno Sa (3):
  iio: addac: add new converter framework
  iio: adc: ad9647: add based on converter framework
  iio: adc: adi-axi-adc: add based on new converter framework

 drivers/iio/adc/ad9467_new.c        | 830 ++++++++++++++++++++++++++++
 drivers/iio/adc/adi-axi-adc-new.c   | 405 ++++++++++++++
 drivers/iio/addac/converter.c       | 547 ++++++++++++++++++
 include/linux/iio/addac/converter.h | 485 ++++++++++++++++
 4 files changed, 2267 insertions(+)
 create mode 100644 drivers/iio/adc/ad9467_new.c
 create mode 100644 drivers/iio/adc/adi-axi-adc-new.c
 create mode 100644 drivers/iio/addac/converter.c
 create mode 100644 include/linux/iio/addac/converter.h

-- 
2.41.0

