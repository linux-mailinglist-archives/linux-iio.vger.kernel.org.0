Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55E3DE97F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Aug 2021 11:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhHCJKC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Aug 2021 05:10:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13406 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234631AbhHCJKC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Aug 2021 05:10:02 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173914Zd020586;
        Tue, 3 Aug 2021 05:09:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3a6w1g8y3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 05:09:51 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 17399nkj049618
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Aug 2021 05:09:49 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 3 Aug 2021 02:09:48 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 3 Aug 2021 02:09:48 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Tue, 3 Aug 2021 02:09:47 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17399jMV011200;
        Tue, 3 Aug 2021 05:09:46 -0400
From:   <alexandru.tachici@analog.com>
To:     <jic23@kernel.org>
CC:     <alexandru.tachici@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: Fix flags in sigma-delta drivers
Date:   Tue, 3 Aug 2021 12:17:41 +0300
Message-ID: <20210803091741.8924-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210731150926.42a2da31@jic23-huawei>
References: <20210731150926.42a2da31@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: eBgZWDpwr_hCudpNERdfG7_BvWYlbRej
X-Proofpoint-ORIG-GUID: eBgZWDpwr_hCudpNERdfG7_BvWYlbRej
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=617 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In Sigma-Delta devices the SDO line is also used as an interrupt.
Leaving IRQ on level instead of falling might trigger a sample read
when the IRQ is enabled, as the SDO line is already low. Not sure
if SDO line will always imediately go high in ad_sd_buffer_postenable
before the IRQ is enabled.

Also the datasheets seem to explicitly say the falling edge of the SDO
should be used as an interrupt.

-Alexandru
