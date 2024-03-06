Return-Path: <linux-iio+bounces-3359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FAD873DCE
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 18:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E6EB22A26
	for <lists+linux-iio@lfdr.de>; Wed,  6 Mar 2024 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9E7FBAE;
	Wed,  6 Mar 2024 17:51:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524ED605DC
	for <linux-iio@vger.kernel.org>; Wed,  6 Mar 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747473; cv=none; b=H9DQYWb02rcUjxr1bSS4HhpsTcO4Z9uatNQa+qz+Et5G2jUzlpDtO2zfVnALV7TfMIp1snN9vtrqFpa1o4VkdciNVoncxgX0o4JdpoHhxbpa6D14H3tvfBI62kbz8K80+ueFHian66YPGUMPUOsGnJ1GS2xGFVBW7IOKZh6jVsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747473; c=relaxed/simple;
	bh=SbKxO11gsgCf2+YKFzMjaD5jNDGDBgQIEec12VHYgaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E89aie1smGq77cbMexXfwu8AVh7HIjG4S3puN61Cl3eGoEl07TQF6SeSzjDp9hMkzo7p/c68Z1e92chB6gIIzzABGuqf5WrHibI2HgWq3lnRk30Fzo85orVo+7WxgPnybZTFzBVM+82p30U+iXEBPnQqZBeIEdUEFSSsjlBfoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPs-0002E6-EE; Wed, 06 Mar 2024 18:50:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPr-004n6Y-3l; Wed, 06 Mar 2024 18:50:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvPq-000nxq-3D;
	Wed, 06 Mar 2024 18:50:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	kernel@pengutronix.de,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/3] HID: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 18:50:47 +0100
Message-ID: <cover.1709747164.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SbKxO11gsgCf2+YKFzMjaD5jNDGDBgQIEec12VHYgaQ=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBl6Kz3lHgUalOU6EkRj8/O9U2IfvVtbGWINY79M jDscycxHSGJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeis9wAKCRCPgPtYfRL+ TiZUB/UWJuP/AGv7iC03TAOK/k2SWrEQ/CzH+6JVZ2vXT+Ga70bnFJu4nDUF8N26NYv3NQFxiy5 JRkzu2gk9+9M/vIbAvKDM9z883ped3UG7k9bHvdzckhzkSGUGIZB6BDuoNMrCFs974BL93ZU/uR Zg61zwmRQM4Z8rQ14GDLuxyWZ91nS+D/Tld1lIeWA+E4wU196M9CYFq1sdjLw8hMpRCOjhjag+I dWhGP6J1y+9rtCI8xNLWAwQg4lodFXgrpwV/cr+GC0ioh8UIkX48y2A4do61+EC8uOjE+RpE0uN eYH+D6vNlRCRZ9AhAxJsa4NeJEBsRT8555fQ9aaNaIF1Ivk=
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/hid to use
struct platform_driver::remove_new(). See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together.

Best regards
Uwe

Uwe Kleine-König (3):
  HID: google: hammer: Convert to platform remove callback returning void
  HID: hid-sensor-custom: Convert to platform remove callback returning void
  HID: surface-hid: kbd: Convert to platform remove callback returning void

 drivers/hid/hid-google-hammer.c       | 5 ++---
 drivers/hid/hid-sensor-custom.c       | 8 +++-----
 drivers/hid/surface-hid/surface_kbd.c | 5 ++---
 3 files changed, 7 insertions(+), 11 deletions(-)

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


