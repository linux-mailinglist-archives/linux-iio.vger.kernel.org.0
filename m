Return-Path: <linux-iio+bounces-8139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9292945F5E
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E71C213A4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11211EA0DD;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+NRMQ7J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE9418B48C
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608831; cv=none; b=nEXPWfw1xhL6LicMgx4Oye1YXYEi7qm9haU8Dc4oBXIaZa0QIX5Sz9fcHNsuVVou4PZXmMPVqXUCaUgbrhEZ6KM4k5/z3rPtk3gCK4WWVKGlET3WMItqCUqeL8uzgTJq2452jkFWzDLH+qYKtp8IZ/qGLeD3IvnXOnMB0IY7U4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608831; c=relaxed/simple;
	bh=pvtbbtM2BoSZ+0w2lcuO7Y9dGXHbuMOSI1xg+oSvlaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e8EI/dmdOPyAzt6IIu5M+3N4q9Zi0R4pKPIQfyQ/KGsBwTn4WfIX3EStqNjT9bwzX5l5k25NvMW+BdaX9RQydtJlB9opEMqn5F7+0lccMOOhz0Hd21J4nvrakjHxVSC9+k/pcG3+eZ9haQ91kMGe7hvJzKNHs55hZUrVX4STdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+NRMQ7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74BD0C32782;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=pvtbbtM2BoSZ+0w2lcuO7Y9dGXHbuMOSI1xg+oSvlaQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G+NRMQ7JRYJ9cqDQwS90M7jRbK4WnGh5ajD2aDtVZSdbFpENbch888kh5LaiAjQ7g
	 XWutO/mDBcekAq3obd4SuCHqiOEdJyA87tGqE4hoQx5E86jQ9B1NhJXgkOqoDRTGAa
	 srFC6DS9UWm6Z/LrymsmOEjrLSm9PcaiNY3lI+7LPcp3pBQoztXThpAZ2v/HDGFeVx
	 7CZVzcIiN/lBt6oLDCHaBwoXaoOMjy1IbBk8R9awiwHoso0hfSlh6s5tCC5Q+y8Xwz
	 SkJtn/y2wBsWPACpDE2u6di0sJS4TXX1iE0SG2jzKh0pp/6EYfYAdnK8bKNGr1rAze
	 qalkOwM8P9B7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E37C52D6F;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/8] iio: adc: ad9467: add debugFS test mode support
Date: Fri, 02 Aug 2024 16:26:58 +0200
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALLsrGYC/x3MMQqAMAxA0atIZgO1VRSvIg6NiRqEKi2KIN7d4
 vj+8B9IElUS9MUDUS5NuocMWxYwrT4sgsrZYI2tTWcsslyouiP5aZPA6Jlzo3OZExqqHFHjG3I
 t5MMRZdb7vw/j+37W5c5PbQAAAA==
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=2012;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pvtbbtM2BoSZ+0w2lcuO7Y9dGXHbuMOSI1xg+oSvlaQ=;
 b=Y9hCuzr4UYA793TawdundcDsEfDhbDAsfJEzLTq8dQo5JLQUuDCps1upTM/PswH4PLYWbOpRg
 cLHhBbcbX2RDz2AVCElwLoESrNUi0VdZK5c3u1hBZXrkn9xiQmWqDQS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This is the second version of the series. I ended up trying the new
directory route and think it does look nice and more future proof.
Biggest change is the first patch where we now pass an info like
structure to devm_iio_backend_register(). Again, this is likely also a more
future proof approach and we would likely need it sooner or later (one
usage I see is for backends to pass in some constant information that
could be consumed from frontends when doing backend_get())  

v1:
 * https://lore.kernel.org/linux-iio/20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com/

v2:
 * Patch 1:
  - New patch;

 * Patch 2:
  - Added backendY directory with the direct_reg_access and name
    attributes;
  - Get the backend name directly from the backend driver;
  - Get the backend index from backend-names FW property;
  - Added debugfs-iio-backend to the ABI docs. 

---
Nuno Sa (8):
      iio: backend: introduce struct iio_backend_info
      iio: backend: add debugFs interface
      iio: backend: add a modified prbs23 support
      iio: adc: adi-axi-adc: support modified prbs23
      iio: adc: adi-axi-adc: split axi_adc_chan_status()
      iio: adc: adi-axi-adc: implement backend debugfs interface
      iio: adc: ad9467: add backend test mode helpers
      iio: adc: ad9467: add digital interface test to debugfs

 Documentation/ABI/testing/debugfs-iio-backend |  20 ++
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/ad9467.c                      | 255 +++++++++++++++++++++++---
 drivers/iio/adc/adi-axi-adc.c                 |  71 ++++++-
 drivers/iio/dac/adi-axi-dac.c                 |   7 +-
 drivers/iio/industrialio-backend.c            | 155 +++++++++++++++-
 include/linux/iio/backend.h                   |  28 ++-
 7 files changed, 499 insertions(+), 38 deletions(-)
---
base-commit: 168bed989d651794d03638e1f7f7b5a800a6f425
change-id: 20240802-dev-iio-backend-add-debugfs-0b13bb5a5b37
--

Thanks!
- Nuno Sá



