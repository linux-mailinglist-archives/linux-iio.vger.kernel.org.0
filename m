Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1740B43B58B
	for <lists+linux-iio@lfdr.de>; Tue, 26 Oct 2021 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbhJZPaU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Oct 2021 11:30:20 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:19372 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236720AbhJZPaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Oct 2021 11:30:19 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19QBBn2p013141;
        Tue, 26 Oct 2021 11:27:55 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bx4fam6ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 11:27:55 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 19QFRsGi030985
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Oct 2021 11:27:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 26 Oct 2021 11:27:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 26 Oct 2021 11:27:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 26 Oct 2021 11:27:53 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 19QFRptT014798;
        Tue, 26 Oct 2021 11:27:51 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/2]
Date:   Tue, 26 Oct 2021 18:27:42 +0300
Message-ID: <20211026152744.129065-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: __m7n8DMWNj_A19NmlbFzf8TQnW5p_bY
X-Proofpoint-ORIG-GUID: __m7n8DMWNj_A19NmlbFzf8TQnW5p_bY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-26_04,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=913 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110260086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADMV1013 is a wideband, microwave upconverter optimized
for point to point microwave radio designs operating in the
24 GHz to 44 GHz radio frequency (RF) range.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf

NOTE:
Currently depends on 64-bit architecture since the input
clock that server as Local Oscillator should support values
in the range 5.4 GHz to 10.25 GHz.

We might need some scaling implementation in the clock
framework so that u64 types are supported when using 32-bit
architectures.

Antoniu Miclaus (2):
  iio: frequency: admv1013: add support for ADMV1013
  dt-bindings: iio: frequency: add admv1013 doc

 .../bindings/iio/frequency/adi,admv1013.yaml  | 110 ++++
 drivers/iio/frequency/Kconfig                 |  13 +
 drivers/iio/frequency/Makefile                |   1 +
 drivers/iio/frequency/admv1013.c              | 579 ++++++++++++++++++
 4 files changed, 703 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
 create mode 100644 drivers/iio/frequency/admv1013.c

-- 
2.33.1

