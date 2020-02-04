Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712B7151886
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2020 11:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgBDKLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Feb 2020 05:11:01 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38910 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbgBDKLB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2020 05:11:01 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014A7H6a001051;
        Tue, 4 Feb 2020 11:10:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=TnBSytEiuHjckJKgIBTRVB3ZknyBFrwKpM8hL2Jzguk=;
 b=wb3Mffm5nr64Cy7DS5Ugp9NJ58r5+3SliuunDgsZmtp4Uzt5Y/crEAjOJKw/Z1ONOIrv
 6Z40Oa04gMOmNrdxiYLAGZreVnLAOSDMi8nllw6SvVPo45PdJr93LPs1wtso/SP2lMfE
 73WSgSPjhB1OnB1x4eC6iHgjopnetFwVp+E16aSLEOBN2Phr1dAoQmX0xa08U90hTzNg
 7lv4S7UmFwmxC1jIOlp+qm3l4YcfIoCIyUBReFFgfKXkH5aU0uArkEcmGYIz9nwfA3z0
 Q98loFxGqyD3N1W3Z3NcWpNjnqEG+LfzxbnOtfzpiVT6262tDvAMFVGdQ8V20MGcMAkI Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xw13nr6wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 11:10:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F5F810002A;
        Tue,  4 Feb 2020 11:10:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 631C82AD9D8;
        Tue,  4 Feb 2020 11:10:30 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 11:10:30
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <olivier.moysan@st.com>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] iio: adc: stm32-dfsdm: add scale and offset support
Date:   Tue, 4 Feb 2020 11:10:04 +0100
Message-ID: <20200204101008.11411-1-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_02:2020-02-04,2020-02-04 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add scale and offset attributes support to STM32 DFSDM.
Also add scale support to the SD modulator, which can be used as input for the DFSDM.

Olivier Moysan (4):
  dt-bindings: iio: adc: sd modulator: add vref support
  iio: adc: sd modulator: add scale support
  iio: adc: stm32-dfsdm: use resolution define
  iio: adc: stm32-dfsdm: add scale and offset support

 .../iio/adc/sigma-delta-modulator.yaml        |   4 +
 drivers/iio/adc/sd_adc_modulator.c            | 108 ++++++++++++++++--
 drivers/iio/adc/stm32-dfsdm-adc.c             | 107 ++++++++++++++++-
 3 files changed, 207 insertions(+), 12 deletions(-)

-- 
2.17.1

