Return-Path: <linux-iio+bounces-2422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97842850B18
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5171C222D1
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565815D743;
	Sun, 11 Feb 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt4z48M0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C405D73B;
	Sun, 11 Feb 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679589; cv=none; b=PLe2WJA1oeGvFtn3md+s3BB6q7RLXagdeneyjXCCgukkw1YWu1qHVGdLvqlFxLNopprbYOPBkybA4tjXatGJjgtouBVOjjcYd0Jfu1aydFe8wd9+RU/NiRKoQ4O4FTGk4otARstnUPQi3NKTpLeM5VOQt2gO9UZD7NgHlof8GhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679589; c=relaxed/simple;
	bh=vmHTqMJCaM//RjQGpI1XRqlrgfC7LCBJBPmL+Qb0aRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r7KR6HuY/FtQchbms4tTBpe1k9Af3v+QQ6f9KesW9xVCo8CRaNn7y/tSy2M5RaMQ/mWFlthEQQlRLnKaFsm7R6+i2asSCT+YS35b8gbE9E7H6BBBtyVLfXZaeN46GjyyD4PAalmbyJuGumvLHEIUCmv1oxNAXt7uej9JeOk6es4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt4z48M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E7C433F1;
	Sun, 11 Feb 2024 19:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679588;
	bh=vmHTqMJCaM//RjQGpI1XRqlrgfC7LCBJBPmL+Qb0aRc=;
	h=From:To:Cc:Subject:Date:From;
	b=Qt4z48M03WOQPBItLKkF3XoaFNjqLW7egePy1RssWjgExRG8M3QRIvG+9Ic+yLg/W
	 DcZde3n0y/iyInC++8oICTe6wf+vJMsucde6hAhsr73kq8U7t+/oQLiOms+0g63xbn
	 V0UnynhwqUWdRiHrEskIbZeZ4nq5+EHlHPlvtmEfR0B6x/pyj4K1YWqcKNKQ+QP+XI
	 x+jLG5hCk/b5IshmtXI3tMV8XxBjRcqjvlaes96DARN1QJMotag3uqKr1ppaN7olFb
	 xbmHhIhC4JnSlEXyUk+Ex9yVqy6IfjyXfW8dc+a880pDauwoLtCmFASw2kmM2u0NHB
	 8VH+fq1JWxuMg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 00/14] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
Date: Sun, 11 Feb 2024 19:25:26 +0000
Message-ID: <20240211192540.340682-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v1:
- Introduced device_for_each_child_node_scoped()
  We may need equivalents for fwnode_for_each_child_node_scoped() etc,
  but this is the only one I needed so far.
  This followed from a discussion of the equivalent patch set for
  device_for_each_of_node() which lead to bringing the declaration of
  the handle we are applying the __free() to into the for_* loop
  initialization.  The avoided issues with the declaration (which also
  effects cleanup order) being nowhere near where it was first set to
  something non NULL.  The disadvantage is that the declaration of that
  local variable is not obvious from the macro parameters. Bugs
  due to variable shadowing might occur, though in many cases those
  are apparent as compiler warnings about use of uninitialized variables.
- Reordered patches to drag the ltc2983 which is teh one case that
   wasn't a loop next to the patch that enables that simpler handling.
   Also move the struct fwnode_handle *ref declarations to where they
   are intialized.  This may look odd, but Linus and others have stated
   this is how they prefer this to be done.
- Converted the one instance of fwnode_for_each_available_child_node()
  over to device_for_each_child_node_scoped() as it never needed
  to be the fwnode version in the first place - that was probably a
  misunderstanding of _available_ or not.
- Dropped tags other than Andy's on the first patch (as that was unchanged
  other than simplifying the patch description).  The code changed too
  much for me to carry them forwards.

As can be seen by the examples from IIO that follow this can save
a reasonable amount of complexity and boiler plate code, often enabling
additional cleanups in related code such as use of
return dev_err_probe().

Merge wise (assuming everyone is happy), I'd propose an immutable branch
(in IIO or elsewhere) with the 1st and 3rd patches on it, so that we can
start making use of this in other areas of the kernel without having to wait too long.

Note I don't have the hardware so this is compile tested only.
Hence I'd appreciate some Tested-by tags if anyone can poke one of the
effected drivers.

Julia Lawal has posted some nice coccinelle magic for the DT equivalents.
Referenced from that cover letter.  Similar may help us convert more
drivers to use this new approach, but often hand tweaking can take
additional advantage of other cleanup.h based magic, or things like
return dev_err_probe().
https://lore.kernel.org/all/20240211174237.182947-1-jic23@kernel.org/

Jonathan Cameron (14):
  device property: Add cleanup.h based fwnode_handle_put() scope based
    cleanup.
  iio: temp: ltc2983: Use __free(fwnode_handle) to replace
    fwnode_handle_put() calls
  device property: Introduce device_for_each_child_node_scoped()
  iio: adc: max11410: Use device_for_each_child_node_scoped()
  iio: adc: mcp3564: Use device_for_each_child_node_scopd()
  iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scopd()
  iio: adc: rzg2l_adc: Use device_for_each_child_node_scopd()
  iio: adc: stm32: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
  iio: addac: ad74413r: Use device_for_each_child_node_scoped()
  iio: dac: ad3552r: Use device_for_each_child_node_scoped()
  iio: dac: ad5770r: Use device_for_each_child_node_scoped()
  iio: dac: ltc2688: Use device_for_each_child_node_scoped()

 drivers/iio/adc/max11410.c        | 27 +++--------
 drivers/iio/adc/mcp3564.c         | 16 +++----
 drivers/iio/adc/qcom-spmi-adc5.c  |  7 +--
 drivers/iio/adc/rzg2l_adc.c       | 11 ++---
 drivers/iio/adc/stm32-adc.c       | 63 ++++++++++---------------
 drivers/iio/adc/ti-ads1015.c      |  5 +-
 drivers/iio/adc/ti-ads131e08.c    | 13 ++----
 drivers/iio/addac/ad74413r.c      | 10 +---
 drivers/iio/dac/ad3552r.c         | 51 ++++++++-------------
 drivers/iio/dac/ad5770r.c         | 19 +++-----
 drivers/iio/dac/ltc2688.c         | 24 +++-------
 drivers/iio/temperature/ltc2983.c | 76 ++++++++++---------------------
 include/linux/property.h          |  8 ++++
 13 files changed, 113 insertions(+), 217 deletions(-)

-- 
2.43.1


