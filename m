Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B657D9ABC
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbjJ0OEv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJ0OEu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 10:04:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0520210A;
        Fri, 27 Oct 2023 07:04:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39RDW8ut000776;
        Fri, 27 Oct 2023 10:04:16 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3tywr0pbrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 10:04:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 39RE4Dap048294
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 10:04:13 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 27 Oct 2023 10:04:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 27 Oct 2023 10:04:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 27 Oct 2023 10:04:12 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.174])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 39RE40hZ022983;
        Fri, 27 Oct 2023 10:04:02 -0400
From:   Ramona Gradinariu <ramona.gradinariu@analog.com>
To:     <jic23@kernel.org>, <nuno.sa@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v3 0/3] iio: imu: adis: Use spi cs inactive delay
Date:   Fri, 27 Oct 2023 17:03:55 +0300
Message-ID: <20231027140358.328699-1-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: p6shrmKnYsB1iwG8_NaMpaRWPGKpWEkc
X-Proofpoint-ORIG-GUID: p6shrmKnYsB1iwG8_NaMpaRWPGKpWEkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxlogscore=973
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310270121
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A delay is needed each time the chip selected becomes inactive,
even after burst data readings are performed.
Currently, there is no delay added after a burst reading
and in case a new SPI transfer is performed before
the needed delay, the adis device becomes unresponsive until
reset.

This commit is adding the needed delay directly to the spi driver,
using the cs_inactive parameter, in case it is not set and is
removing the additional chip select change delay present in adis
APIs to remove the double delay.

Ramona Gradinariu (3):
  iio: imu: adis: Use spi cs inactive delay
  dt-bindings: adis16475: Add 'spi-cs-inactive-delay-ns' property
  dt-bindings: adis16460: Add 'spi-cs-inactive-delay-ns' property

 .../bindings/iio/imu/adi,adis16460.yaml        |  4 ++++
 .../bindings/iio/imu/adi,adis16475.yaml        |  4 ++++
 drivers/iio/imu/adis.c                         | 18 ++++++------------
 3 files changed, 14 insertions(+), 12 deletions(-)

--
2.34.1

