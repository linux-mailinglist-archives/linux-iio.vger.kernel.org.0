Return-Path: <linux-iio+bounces-15320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFACA30384
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 07:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345CE7A2E25
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 06:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C81EBA03;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOUv8xbi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749331E9B3D;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254995; cv=none; b=Duw1G+5s/AVRRbxoEmh4pl6zEP0ktQjEhFRIsUnXgMT0KU06iSWAdkRfU2DQHicbaz2muC3yo7AsIv0Pxd57rEN5ZGZN6YRa+uPyUexjLsePFoBa1DYnHENIMZwvAZfEGwE0bwclkUCH0Lw+7cRxSb4pY3hPggvpO+FABxRg+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254995; c=relaxed/simple;
	bh=QXk/JHBxUK/Ths9qSQMqY9AnKVsl6SgMJq6d9H2BT/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YflDUGS+ILXCbJ7uWZCwtY8eEmEvOStCDydZL5Bp4w0mlh16khkw3MdwAmhSmRt0AAGvNE9zS+SdUsjZ/HVbpgtPrLe4b2QHE9eh59wlcUr+EJSmE3MPMGL7YfHu06HShTOx7avuJoj0OAU8LyLFlVozuduUzjpRmP8fff6dXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOUv8xbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA6C4AF09;
	Tue, 11 Feb 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254994;
	bh=QXk/JHBxUK/Ths9qSQMqY9AnKVsl6SgMJq6d9H2BT/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOUv8xbi9st74/o9+AtogiTH40aS0q0hLloHaZz1sRq0DuFfWVK6OEkHJ0YMRWqmh
	 tdTAAyL2pHaiBMzpTNF7kmcuACYWZH/8EwqX4IOLF5ydzhEuzVINSRZfxm/jwzJAwX
	 Y2TgNR9A5fQhIEN0rKhEWxt62lMyAfswm7KTMAmK1O6t6yFa24HARZK0Ca4/fnRWJg
	 6QfX5g8mF7V4SsCc8pzg7vWgO4ykROcaHQKTR8IfiSBkafucV0Eb6fHxCnSMLlxHy0
	 S3x+5UYu+kdFn1kfX3yMcpb9s7fiX/bmshKsezlmZqyYpzI0uW19bo/hPmEqQFHGsF
	 QN7Y+3FxthBUw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjfs-00000008YBX-3XNq;
	Tue, 11 Feb 2025 07:23:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	William Breathitt Gray <mchehab+huawei@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] docs: arm: generic-counter: Allow creating cross-references for ABI
Date: Tue, 11 Feb 2025 07:22:59 +0100
Message-ID: <5faafb98c331e0c99433f36dd72badcc540a1baa.1739254867.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739254867.git.mchehab+huawei@kernel.org>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that Documentation/ABI is processed by automarkup, let it
generate cross-references for the corresponding ABI file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/generic-counter.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 71ccc30e586b..e826f16ea43d 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -467,7 +467,7 @@ Counter sysfs
 Translates counter data to the standard Counter sysfs interface format
 and vice versa.
 
-Please refer to the ``Documentation/ABI/testing/sysfs-bus-counter`` file
+Please refer to the Documentation/ABI/testing/sysfs-bus-counter file
 for a detailed breakdown of the available Generic Counter interface
 sysfs attributes.
 
@@ -483,7 +483,7 @@ Sysfs Interface
 Several sysfs attributes are generated by the Generic Counter interface,
 and reside under the ``/sys/bus/counter/devices/counterX`` directory,
 where ``X`` is to the respective counter device id. Please see
-``Documentation/ABI/testing/sysfs-bus-counter`` for detailed information
+Documentation/ABI/testing/sysfs-bus-counter for detailed information
 on each Generic Counter interface sysfs attribute.
 
 Through these sysfs attributes, programs and scripts may interact with
-- 
2.48.1


