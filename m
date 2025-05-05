Return-Path: <linux-iio+bounces-19172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A309AA9D75
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 22:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0146D3AFEF5
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F497270EA6;
	Mon,  5 May 2025 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="AOuJityf"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E8A2701C1;
	Mon,  5 May 2025 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477696; cv=none; b=dfxabwwB4CrCsLzMPpxoacUn+GY9d99o15S48qJimevHc1wNuGEOrm6vb5m/jh7wzagqh3NZE4hBzUpI0vASNYGNFbz7/S/qf40dF+GZYF0gP//FaFZz4wT+X5EwpA+QZZj0IUcyc4y5TH9DCvxv8NBmBWgZ2wqtp5eb49LF9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477696; c=relaxed/simple;
	bh=C4w+n1SFwBILVTrP0ZDWUn0rbvQgPl9+OR8BMaAo6TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlYUmVBEVhZPVvb+FWnBvXd1iXSp/BLhOUU1+KmfTzkEFNuipxWzWbeC7HyMT3vPjshWr9mSKrPQiyowyxzfQOtcQO4jzJ1jWvTP7QOVHbDBaAtfxp9ZwznJ9NGKTxwqt+s806m2hExVqg3T7lrKO8WI0Hu7TLIJQnuEHJCtEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=AOuJityf; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=CB/REm5kGRy8MKTNFF1/5m5GNiYMtLHufcGHXvoTW7A=; b=AOuJityfr+UM42M0WuFfrTN1Fv
	/ju0QudlP1Bmpy5efAv63sfcZpkW6tR+FbMYtFdp1VUF1GKMHjk1EpSVmb+AO9lq8d0ivKylNC2SC
	L59dZ2PRfWcXvN4n3ulQNHStx+ZM6u/873GRuqXltPy7fam3N9xPp7+BYm1AKruDo7ZG6EaZkMDRE
	56jpZu8RjAyczU0LTxBVcSbQ13KeV0ZeciZdQ6g1JABfo/s5/KIkeWta0iTq7C9LdRnl1XQPPw/Bl
	SKkzcpxbTgYbRbcQPZEvz6nzK2oGmM/3uAM5iOp8M6z2mvWnvwh9hkoacHG04MGRZV0CVd7PQ9gve
	GDKimrew==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2MW-000Dov-1l;
	Mon, 05 May 2025 22:24:28 +0200
Received: from [31.220.118.240] (helo=anderl.fritz.box)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2ML-0007So-0p;
	Mon, 05 May 2025 22:24:18 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Andreas Klinger <ak@it-klinger.de>,
	lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	muditsharma.info@gmail.com,
	perdaniel.olsson@axis.com,
	emil.gedenryd@axis.com,
	mgonellabolduc@dimonoff.com,
	arthur.becker@sentec.com,
	clamor95@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] iio:light: add driver for veml6046x00 RGBIR color sensor
Date: Mon,  5 May 2025 22:23:10 +0200
Message-Id: <20250505202313.205522-1-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)

This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor

Changes in v3:
- implement a lot of feedback from Jonathan
- change scale value to real factor of lux per raw count instead of hardware
  gain
- optimize code by using more lookup tables
- remove unimplemented threshold functionality

Changes in v2:
- fix missing include for example in vishay,veml6046x00.yaml

Andreas Klinger (3):
  dt-bindings: iio: light: veml6046x00: add color sensor
  iio: light: add support for veml6046x00 RGBIR color sensor
  MAINTAINER: add maintainer for veml6046x00

 .../iio/light/vishay,veml6046x00.yaml         |  51 +
 MAINTAINERS                                   |   6 +
 drivers/iio/light/Kconfig                     |  13 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/veml6046x00.c               | 889 ++++++++++++++++++
 5 files changed, 960 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
 create mode 100644 drivers/iio/light/veml6046x00.c

-- 
2.39.5


