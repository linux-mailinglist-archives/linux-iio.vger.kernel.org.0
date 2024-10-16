Return-Path: <linux-iio+bounces-10659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC409A0C7F
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 16:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723B2280D98
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542F207A13;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNOXYERT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A820697B
	for <linux-iio@vger.kernel.org>; Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088522; cv=none; b=bYla+aUAl3oaq+lsroqnPCWG5tmpeytj+OhziYEmzuhu1gCR+JpXkGVzBjo8osrLJRWNtCuf46ehx6Orom5n1Kmp4FGcOgNncPpGvoap8nf1zntxxsAbnshbSVRgDh5QOuJenwGfai2veExzAvm+6hzydcnENbk5wlgtqKeugic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088522; c=relaxed/simple;
	bh=Nuvxba6glBIPMK9JE7/jPpniFHYRMPEJCRIpZ014R2A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oYowX4m2hKgn0tEb9EGdWT4km4GR0nGZBu5fbwqE3V/sUi5AfCjX1r1tAimGHXKrwyLKsQLPq226Vzmwd9kVNDg0hdU59kIn2d74LBPNReko3gdNspNW5LcShixtOWq7Jb6kgl1j0J315+nk6GbtEzc8VQq1IcQ8RoUMvUH+9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNOXYERT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3022DC4CEC5;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088522;
	bh=Nuvxba6glBIPMK9JE7/jPpniFHYRMPEJCRIpZ014R2A=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FNOXYERTyn4hUUGVLar/mxvfP4tOtm+Ergu04vhUVJF3IZ+IiEeg+YOTG4HB9hFZG
	 Li7dAwiIFtmeiw+oi6xax7jGUGEg4MAmqtOTFi2yiLdhr2uF/WjTs6dob0uO6LUwSz
	 tF0JJ1+OV6v/wnlHUyUgiYeJf9Fpx++weOI1vaSY7nxK6pGH8b4EuGVD85x3Upax5d
	 g4twnKZkBNlcLBZMXcuOIuvcJ+Tq6ustNiWywF8wx+wAJGtqbw2ezLRDO24kUJqF6G
	 JRWcifOtTlye5TxfFxGgAtjsYanRHkY3ynoxXpm9fVWIzP5O03mt0a5ZybmpTPPo7C
	 GyHUOBZ+XJD6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F2D206AB;
	Wed, 16 Oct 2024 14:22:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/3] iio: addac: ad74413r: minor improvements
Date: Wed, 16 Oct 2024 16:21:58 +0200
Message-Id: <20241016-dev-ad74413r-minor-improv-v1-0-13c9c769237d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAbMD2cC/x3MQQqEMAxA0atI1hNoNDjiVWQWOolOFraSQhHEu
 1tm+Rb/X5DVTTOMzQWuxbKlWEGvBr6/OW6KJtXQhpYpUI+iBWd5M1PnuFtMjrYfngrKsISehLn
 jAWp/uK52/t/T574floPJ7WsAAAA=
To: linux-iio@vger.kernel.org
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729088521; l=602;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Nuvxba6glBIPMK9JE7/jPpniFHYRMPEJCRIpZ014R2A=;
 b=pYpN9jjSalNp3z4sZ8TG7wu49h9ql2KLJKULCYaqoLSasV2VuASRAeZ4iYcmggQMb418DS929
 aOsiGzfHyI1AignLcW1X3bY2ukWg6YQwVunkUOAFaaWyYraXEGS1xmI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Minor improvements handling locking, reset gpio and vref voltage. No
functional changes intended.

---
Nuno Sa (3):
      iio: addac: ad74413r: drop reset_gpio from struct ad74413r_state
      iio: addac: ad74413r: use devm_regulator_get_enable_read_voltage()
      iio: addac: ad74413r: simplify with cleanup.h

 drivers/iio/addac/ad74413r.c | 81 ++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 51 deletions(-)
---
base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
change-id: 20241016-dev-ad74413r-minor-improv-d8b061d44348
--

Thanks!
- Nuno Sá



