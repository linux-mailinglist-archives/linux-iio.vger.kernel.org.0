Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B09E75DD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2019 17:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfJ1QM3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Oct 2019 12:12:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23722 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390826AbfJ1QM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Oct 2019 12:12:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9SFuCiJ007143;
        Mon, 28 Oct 2019 17:11:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=ULIF3nGXJmIbXhgf4TYuqp1B8PHksrpUdhfUfjdzh7g=;
 b=YvEIq1+R8QzfF3ZFSdqiEMZX5FrHw2X+7+YPzgc9tTFY2FuXcwz3ozfzfA0wMqYfKNrT
 yDXuz+PuKy6P1IovkdYg/RMR8KR24EQGPic+HwDMidiEuLNnmEol7uu53+eZleYtC/9y
 pcTflqj3KFuQXrLiNU2jXzWQiOJ7dEh2SxnGSl4/1gnuax95aindMURTem4nW0jvgpP0
 XTn6uJNpbgoEUQne6XbNfLMqyMOMM0si86/10jNd+QaBSZ4nvSd4dV5JyleBOrgOZfd5
 2gDrAvgKwWZAPANlNpKDnLzywIcUuq8x+NiBIkGrMhTuyROVH6mNGjQ58owoSlGOwU5r 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vvbm0b68c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Oct 2019 17:11:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 00E0D100038;
        Mon, 28 Oct 2019 17:11:54 +0100 (CET)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0C252B1E73;
        Mon, 28 Oct 2019 17:11:53 +0100 (CET)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct
 2019 17:11:53 +0100
Received: from localhost (10.48.0.192) by Webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 28 Oct 2019 17:11:53 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] iio: adc: stm32: add max clock rate
Date:   Mon, 28 Oct 2019 17:11:46 +0100
Message-ID: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-28_06:2019-10-28,2019-10-28 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add optional dt property to tune maximum desired analog clock rate.

Fabrice Gasnier (2):
  dt-bindings: iio: stm32-adc: add max clock rate property
  iio: adc: stm32: allow to tune analog clock

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt         |  2 ++
 drivers/iio/adc/stm32-adc-core.c                         | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.7.4

