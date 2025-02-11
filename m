Return-Path: <linux-iio+bounces-15318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE53A30375
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 07:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68DC16762F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42D1E9B23;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyPX0pA5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC71E5B66;
	Tue, 11 Feb 2025 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254995; cv=none; b=bptohdqSzKNYrGZsWhya4KaGo5qVB6xDL8rMrt+P3Vk7Y14t5LFQrddyXOY0Iar9I+vfPs2vpaHPC3slSn/hhpwkvBhZgJQN48SozAK/tsUI9Offevkmo1SV4Jc4VSLhFYc8NicfgIoRPFwEJm/5K9G1KMp8wqAnAXBzL00jWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254995; c=relaxed/simple;
	bh=OO6X48oMD1uFUOD5elmk8YCfoS/Rml763B+Am/9mOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPxmSF2DPx7DaGYOIHKy6GysOrp+Zv2aGHSqCWKinRc30H0tQxtjADjisM1ZI+Uh5dHNFnN9pTPnpqPuXbh88rjpkFLxQN5bOKUv06zzfcg8o/VSSwVlKiKcGrUDo0ngYdLqy9cw4hkK9xijw76D7fAbItWMrggBLFsXwRGMdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyPX0pA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE8DC4CEDD;
	Tue, 11 Feb 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254994;
	bh=OO6X48oMD1uFUOD5elmk8YCfoS/Rml763B+Am/9mOOc=;
	h=From:To:Cc:Subject:Date:From;
	b=iyPX0pA5AG6JuBzDJhoXbZm+u09Ly/vfgxYiqyrlnGOKVFWTfN0tWWiye88LDOJmE
	 c8JfHUTrSEZmaEtOvb/llUXNoV2N1SOezBdAxjaxY9MWPyYTi7d1a/ZJk4hCw5MV0y
	 f+ESJmKKg+iFde9Y624LY1xVA0zJCa7XK+SO6clqtDSfwIcScP3r4rg0nLgaheFUKg
	 +JU00b3Xt7KGFVF/+alS8Y5/JgNy7eBzsy+E3IdHJdCPGpK1f1K6aTwfofhNil67UR
	 gqEmNdJH7Tpyg22fEsFX4yPqk9j9y5quz3jbQjxqM/ctDs0YsMovmUbLJESmPvJd8m
	 nX60ELz6H60WQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjfs-00000008YBE-2xQJ;
	Tue, 11 Feb 2025 07:23:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Alex Shi <mchehab+huawei@kernel.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Carlos Bilbao <mchehab+huawei@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Young <sean@mess.org>,
	Simon Horman <mchehab+huawei@kernel.org>,
	Will Deacon <mchehab+huawei@kernel.org>,
	William Breathitt Gray <mchehab+huawei@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH 0/9] Extend automarkup support for ABI symbols
Date: Tue, 11 Feb 2025 07:22:54 +0100
Message-ID: <cover.1739254867.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that ABI creates a python dictionary, use automarkup to create cross
references for ABI symbols as well. 

Mauro Carvalho Chehab (9):
  docs: media: Allow creating cross-references for RC ABI
  docs: automarkup: drop legacy support
  docs: thunderbolt: Allow creating cross-references for ABI
  docs: arm: asymmetric-32bit: Allow creating cross-references for ABI
  docs: arm: generic-counter: Allow creating cross-references for ABI
  docs: iio: Allow creating cross-references ABI
  docs: networking: Allow creating cross-references statistics ABI
  docs: submit-checklist: Allow creating cross-references for ABI README
  docs: translations: Allow creating cross-references for ABI README

 Documentation/admin-guide/thunderbolt.rst     |  2 +-
 Documentation/arch/arm64/asymmetric-32bit.rst |  2 +-
 Documentation/driver-api/generic-counter.rst  |  4 +-
 Documentation/driver-api/iio/core.rst         |  2 +-
 Documentation/iio/iio_devbuf.rst              |  2 +-
 Documentation/networking/statistics.rst       |  2 +-
 Documentation/process/submit-checklist.rst    |  2 +-
 Documentation/sphinx/automarkup.py            | 47 ++++++++-----------
 .../it_IT/process/submit-checklist.rst        |  2 +-
 .../sp_SP/process/submit-checklist.rst        |  2 +-
 .../zh_CN/process/submit-checklist.rst        |  2 +-
 .../zh_TW/process/submit-checklist.rst        |  2 +-
 .../userspace-api/media/rc/rc-sysfs-nodes.rst |  2 +-
 13 files changed, 32 insertions(+), 41 deletions(-)

-- 
2.48.1



