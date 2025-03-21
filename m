Return-Path: <linux-iio+bounces-17177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AB9A6BD97
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615BE462DCB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616341DEFC5;
	Fri, 21 Mar 2025 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tIbopaX6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F91DED49;
	Fri, 21 Mar 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568649; cv=none; b=ujoSyfqrfWX8Q0r96gwQL86sCg+Sn/+HpBlR+RpSqoJuuU7noYQzi7kx/5z16ao4xKWFOBJEGkeF/zXL6lEGLAoZ4JqRBaIzTniBU6sl1P4vq28gTgzKLM7qQsil9kHJQAYKB+1V+5kbnBuSWHAgOHsbij/F2Pp/OmMydAEo/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568649; c=relaxed/simple;
	bh=/fke0FZvpYVr1VpmHVa1ygKLi+Vnc7JrixCJyNiA7Ro=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dEemYuzaHE2rn0sHGUtRa2rYVltnbvRI5WX7jh2pMN9ZhBKUQfNLOwyJEd0qsXbHjkGvI4Lt1iZ4bR9vWrff9dIq+bWywdNHoDN9Qbwumid3jHxlfu2ezRw673T9p5Eln7tAsg1k5A3W6KokcBrn4O9D0cKEneKCdfqikwRS6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tIbopaX6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LBNahF009105;
	Fri, 21 Mar 2025 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=oSg1mqldn0GUtZnijpXisy8J008
	1sPGcJiDUPXyz7ws=; b=tIbopaX6HGC8QCwC+dAD5so+fDyi3W8Txc7Kj3suLGK
	6xAl/DZhVvzuPTmDs2yPkCdCNOqPirIb2VI6zzAzJOXqdA5yFyTUTf65Dx4YXWof
	arBFUddYtfCvjV7FHUwPVl/H2crqVht4S3mdQRYj6n7IsdrFhqjyPoq/eAIIjUGr
	J3553mhvH1vadTVWfGpmEhRcBNjalg+RdS6LKhj70ZbM5KYVI8CYP1naCc+1Rs05
	eeNjc/9unqNT0KCNTfTnOITeivuJigOrQYJlbdmi5OyGbSesmz11fzo03ov0hStP
	oWiOMbPy+tT6WI3nMIgRLalZD7EZOT2ubI6QBIdpNdw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45h76sgvv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:50:14 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52LEoD42057363
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Mar 2025 10:50:13 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Mar 2025 10:50:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 21 Mar 2025 10:50:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:50:13 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.52] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52LEo1ca011710;
	Fri, 21 Mar 2025 10:50:03 -0400
From: Jorge Marques <jorge.marques@analog.com>
Subject: [PATCH 0/2] Add sys-bus-iio ABI frequency options to events and
 oversampling
Date: Fri, 21 Mar 2025 15:50:00 +0100
Message-ID: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJh83WcC/x3NQQ6CMBBG4auQWTtJKcjCqxgXtfzFSbTgDDYaw
 t1pXH6b9zYyqMDo0mykKGIy54r21FB8hDyBZawm7/zZdb7lcBeeC9TCa3lKnhgFeTVOivcHOf6
 474Y49CkiwlHtLIok3//jetv3A0oJp3BzAAAA
X-Change-ID: 20250321-abi-oversampling-events-frequency-436c64fcece0
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <dlechner@baylibre.com>, <Michael.Hennerich@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jorge Marques
	<jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742568601; l=1384;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=/fke0FZvpYVr1VpmHVa1ygKLi+Vnc7JrixCJyNiA7Ro=;
 b=oGmhiPlKHkAucSXkcrRtxLPvHxede8avNQEhNkVGfpR4Jzj1pj5RUvB6Sawr61bxsgTvBfyt+
 8Z3gKx5e12BCFN0O6pf/V/39gvLhOqoAPRRFiDy5Q3Xtyn0GjE05Zge
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: kDfaLNeq1FtB-ErZ3PxTjZcICSu206o-
X-Authority-Analysis: v=2.4 cv=BpidwZX5 c=1 sm=1 tr=0 ts=67dd7ca6 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=sbcHFVb_5Oqvkv0eGmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kDfaLNeq1FtB-ErZ3PxTjZcICSu206o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210108

Some device families such as Analog Device's max1363, ad7606, ad799x, and
ad4052 contain internal clocks used by monitor modes and oversampling.
Devices' monitor modes are exposed as IIO events.
The max1363 driver included the events/sampling_frequency in
commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
and ad799x in
commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
hysteresis")
but went undocumented so far.

The oversampling sampling frequency is a planned feature to be patched
onto the ad7606 driver.
In this particular device, it is called oversampling padding.
The upcoming ad4052 linux driver will utilize both entries,
it is worth noting, however, there is a single register for both
options. Since the device is never concurrently in both modes, the
values will be safely cached on the device state.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
Jorge Marques (2):
      Documentation: ABI: add events sampling frequency in sysfs-bus-iio
      Documentation: ABI: add oversampling frequency in sysfs-bus-iio

 Documentation/ABI/testing/sysfs-bus-iio | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
---
base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
change-id: 20250321-abi-oversampling-events-frequency-436c64fcece0

Best regards,
-- 
Jorge Marques <jorge.marques@analog.com>


