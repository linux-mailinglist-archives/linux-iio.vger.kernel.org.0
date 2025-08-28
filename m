Return-Path: <linux-iio+bounces-23347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8D9B3AD5C
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 00:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2E49864CA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D21265CCD;
	Thu, 28 Aug 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="s2siQnBz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD061865FA;
	Thu, 28 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419501; cv=none; b=NHoALqcJ+AeyVd4z7RcBfci2Yb6UpmWUzPJ2H2DuRSXqZeuM3UyiK1zxKSEqKahdikOA9w35WhNV0s1mAYyRrDKvIGsX8wOeY/BBMckuELnQ8lUkvg+z6uGT81j+b6PBH3/X9mjHt8ygjly4Qpenl3RzIJlb8D8hmak75L5qYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419501; c=relaxed/simple;
	bh=GwxFobsrzUnyTVxmOQCIsA2yyMZw1r5E6V7+lS5C3HA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iO8zFTjMKMvyUbztLCjdkYieO+0ZL0Bb/jjA1xauA+rMq7nv7pFgvwhmNtX6KoGSmZ7jQCU/zL/Ae9neZoWPlvRPZvxYfbtGzmi1xVbNvpsNhrPh2eV7mCTYhEfYmJHXKzRR9IJnS5PiWMpqsP8Ns0dzYWEC7DAyde7S998j34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=s2siQnBz; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=b60qny5Vy5JUP/CUvf2JgCz13q8en7E+ypYRgjRaB1M=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756419475; v=1; x=1756851475;
 b=s2siQnBzLSbJIPmgyZpnSuhAsQTe7fGSid5MWDsAPjLqiGa04SPT7KqhfExS3NxXXvn/LjPN
 aUm0yGCJ2cU4zX29+vM8mEyLoNbPYgxqLJjjIN3lAqTDtw2CCK0/o6iVVoaARtwubyRT9krxveM
 OuKNyCFkHbnzVJbRA6NlyUcI091Kr+wQHAjADshmAJWQfZgo77nymnzRCDzMbCXldbiXzm6fZ93
 KpiqtfB+mw4TfVhcT6I+pEZDGeKW4/8zeUlbgTwFKBHRebyQpkYsY42j/oeMmlxsCHU2HTqvjCV
 HmGJriwgpDQtbcIjJxvjCYA0Lqtj9feHoK+wqvx3eL21Q==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 33160353; Fri, 29 Aug 2025 00:17:55 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH 0/2] Marvell 88PM886 PMIC GPADC driver
Date: Fri, 29 Aug 2025 00:17:40 +0200
Message-Id: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAITVsGgC/x3MQQqAIBBA0avErBN0wBq6SrQQnWwWmShEEN49a
 fkW/79QuQhXWIYXCt9S5UodZhzAHy5FVhK6ATVaTTgronwSTSpmF7wiw+idCRY9Q29y4V2e/7d
 urX31LXeEXwAAAA==
X-Change-ID: 20250827-88pm886-gpadc-81e2ca1d52ce
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=GwxFobsrzUnyTVxmOQCIsA2yyMZw1r5E6V7+lS5C3HA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbrk4q/XdE+ubczKiQmQdlEtOlpm3XPpr+R+X7Be2/x
 RJFzdEKHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjAR4wWMDFctWOqLi15N/8uo
 6Nlmd/dWSyDXL/3GDe+zMx88Xtl2uYOR4WChQsemmxxLX9ksYNadIH0ktPHvpUcbmVyXz1NlXvp
 yCycA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

This series adds a driver for the GPADC found on the Marvell 88PM886
PMIC. The GPADC monitors various system voltages and is a prerequisite
for battery monitoring on boards using the PMIC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Duje Mihanović (2):
      iio: adc: Add driver for Marvell 88PM886 PMIC ADC
      mfd: 88pm886: Add GPADC cell

 MAINTAINERS                     |   5 +
 drivers/iio/adc/88pm886-gpadc.c | 352 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/Kconfig         |  10 ++
 drivers/iio/adc/Makefile        |   1 +
 drivers/mfd/88pm886.c           |   1 +
 include/linux/mfd/88pm886.h     |  30 ++++
 6 files changed, 399 insertions(+)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250827-88pm886-gpadc-81e2ca1d52ce

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>


