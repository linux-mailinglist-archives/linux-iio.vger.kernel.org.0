Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743B4F115D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiDDIvj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Apr 2022 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241353AbiDDIvj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 04:51:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0473A1EEDA;
        Mon,  4 Apr 2022 01:49:43 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2347taGt002597;
        Mon, 4 Apr 2022 04:49:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f6gb6usdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 04:49:31 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2348nU68054365
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Apr 2022 04:49:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 4 Apr 2022
 04:49:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 4 Apr 2022 04:49:28 -0400
Received: from nsa.ad.analog.com ([10.44.3.67])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2348nIU5027819;
        Mon, 4 Apr 2022 04:49:20 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 0/2] ad3552r change maintainer and update MAINTAINERS
Date:   Mon, 4 Apr 2022 10:49:58 +0200
Message-ID: <20220404085000.249423-1-nuno.sa@analog.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gU78I2rYTIFzOBxAHvrhQpodSt2sjTR2
X-Proofpoint-ORIG-GUID: gU78I2rYTIFzOBxAHvrhQpodSt2sjTR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_03,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=633
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040048
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After the bug report in [1], it came to my attention that the maintainer
for this driver is outdated as Mihail Chindris moved from ADI. As such,
change the maintainer to myself. On top of this, I then realized there
was no entry for this driver in MAINTAINERS so add one.

[1]: https://lore.kernel.org/all/20220106103553.GA26440@kili/

Nuno Sá (2):
  dt-bindings: iio: dac: change ad3552r maintainer
  MAINTAINERS: add ad3552r

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml          | 2 +-
 MAINTAINERS                                               | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.35.1

