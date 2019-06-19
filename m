Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA84B94C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbfFSNEZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 09:04:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17258 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfFSNEZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jun 2019 09:04:25 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JCuBsW030426;
        Wed, 19 Jun 2019 15:03:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=iujWyaLCp1yh3WAwepteDeXAm/rq9tWRC+STHY0lkfE=;
 b=hp7o3lBcKOgc5RGR6SJ+PIyrZXgOU7T3o+HX1UMkMyTpkK+ytnl+N3MRTjcFsyiJkQKO
 UGqugdp+C01wkx+1FrgEeSXg1q1Fj25vZcVRvMdY9gTU5K5cxlnFdUlWFyCImGjiLBPl
 etpHvNb6rVL9Kb+53EIFxmph9mxqF2gdFq37zySslBHvHzLdsWaJ5K8uQ4Hbk0M6ymly
 4T4JAbZOc+Rk8iCwqtCFVYNJQAQcLZcoqxdrPqjB2zP2lJSrWXr5RhvL+yzKn/8Wd4tO
 4HDiVf9YfYPeL+n7tOGhm1bnGDCVLqq9KXv77ykG8sBzghJ49AnFwz6aHsPG/RzvIIew aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t781a3yxc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:03:55 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B49634;
        Wed, 19 Jun 2019 13:03:54 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17F142831;
        Wed, 19 Jun 2019 13:03:54 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun
 2019 15:03:54 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 19 Jun 2019 15:03:53
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <olivier.moysan@st.com>
Subject: [PATCH 0/5] iio: adc: stm32-dfsdm: fix and improve output data managementiio: adc: stm32-dfsdm: fix and improve output data management
Date:   Wed, 19 Jun 2019 15:03:46 +0200
Message-ID: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_07:,,
 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch-set provides some fixes and improvements regarding output data format
for STM32 DFSDM.
- Fix output data resolution and saturation management in continuous mode
- Fix data type
- Apply same processing on data in continuous and triggered mode
- Add fast mode support to get better resolution for output data
- Add a comment about 16 bits data transfers

Olivier Moysan (5):
  iio: adc: stm32-dfsdm: fix output resolution
  iio: adc: stm32-dfsdm: fix data type
  iio: adc: stm32-dfsdm: manage data resolution in trigger mode
  iio: adc: stm32-dfsdm: add fast mode support
  iio: adc: stm32-dfsdm: add comment for 16 bits record

 drivers/iio/adc/stm32-dfsdm-adc.c | 233 +++++++++++++++++++++++++++++++-------
 drivers/iio/adc/stm32-dfsdm.h     |  24 +++-
 2 files changed, 208 insertions(+), 49 deletions(-)

-- 
2.7.4

