Return-Path: <linux-iio+bounces-21501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D593AFFB10
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A0C17003C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE528982D;
	Thu, 10 Jul 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="JvP0dPmF"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022619E7D1;
	Thu, 10 Jul 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133156; cv=none; b=ESvvC/9qPmYeOt9j6YpD06khUftKuDQ6ImtSuxU1ioLGz+AGW9r8GgxBUxzqOD9j5GgVm1Q9ye2txctDzDY155wvyrSTyjDCaKGSkG0xNRT4rW5/TDudeoPbVbBeomU8WT38g6wPP/ALUBEfT1NJFa8E+GT1zjCnyyvhfeCr1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133156; c=relaxed/simple;
	bh=w4taWM7GTvBGEd88jMF9XlMxryMoUI3FMR86s6vtuo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BEESmM50Wzx0FBny92bpPdKmz2wcQ9tck1AGPDukFz/33LSmHvrTM+kV5SfIowWHTmxm6+wKspsyLsh/+Q62Du0SzFz4R2pXDptstQVHC13FGuDmy8Oj+mZq0TgPeH2pDWp3rk7itVATr/V8/Ge0NtbQDHVHcKznWKjMRKIwWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=JvP0dPmF; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/c6PpFZxX2IwuD64HEN0TwJd8WKn9bagu6C1XSQwuQA=; b=JvP0dPmFYZUVUdl1wgJrXB1SaD
	rRq2WFj+DH4ZNfKSIRp0zp/79ug8oz9hbuSi4nyKqqLXaa4aQE7cMf+bOPYJPsfDwRrZnp3RDShkQ
	pY+qc2LaEf+EyKhEOlps0nX9O6gltrDNihJW7sh+u4zp+FrFN11Rp/CJyKW6rhg35QC+93xK+ezdE
	qmuMM400DBI0SJzzOrDYFgjA/h5uEdPs3gfnoGP8YjEwfZrtUtT03u5jI4CNZGZGi/s/DwGz7qSSi
	q8o0YT37TG+LC9rLLMM/FY9AtN+zPZc+JHNJPH/wQlIW7UK90m3fyuEZF0mHFd4fEgJAB87BpBKj2
	5aCntzRA==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:48064 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uZls3-006IV5-08;
	Thu, 10 Jul 2025 09:39:06 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	andrej.picej@norik.com
Subject: [PATCH 0/2] Make i.MX 93 ADC calibration params configurable
Date: Thu, 10 Jul 2025 09:39:02 +0200
Message-Id: <20250710073905.1105417-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The i.MX 93 ADC calibration parameters are configurable in the MCR
(Main Configuration Register). One can tweak bits:

 - MCR[AVGEN]: Enable calibration averaging function,
 - MCR[NRSMPL]: Select number of calibration samples,
 - MCR[TSAMP]: Select sample time of calibration conversions, 

Make it possible to configure those parameters via the corresponding
device-tree properties.

This patch series is based on the one we submitted in March 2024:
https://lore.kernel.org/linux-arm-kernel/20240320100407.1639082-1-andrej.picej@norik.com/

Changes since the original submission:
- rebase on linux-next
- reorder patches (bindings before users)
- fix checkpatch errors
- reword commit subject & body
- implement feedback from reviewers


Andrej Picej (2):
  dt-bindings: iio: adc: imx93: Add calibration properties
  iio: adc: imx93: Make calibration parameters configurable

 .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 ++++++
 drivers/iio/adc/imx93_adc.c                   | 75 +++++++++++++++++--
 2 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.34.1


