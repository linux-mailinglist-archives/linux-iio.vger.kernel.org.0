Return-Path: <linux-iio+bounces-3941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048DF892CA5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8381C21296
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E573837162;
	Sat, 30 Mar 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drra6xv/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A470F2E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824801; cv=none; b=eVQZfVm5elOQFu2zmLIWU/5Hkc6XDc96j9QMvcd3vT5GaEDvDI8z85Qr/ymTDwsG6HObZJvHiJt7g4O0THgySdZd20kZWhfrUU6Rvk7xMDXz7N4Ahe7r2sgt1ehzALg+ckLoO7TTqPFAgVEx0PEVnyASXTbz/VowDBl/O2yQQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824801; c=relaxed/simple;
	bh=dJfiZr7ed3decL5IM76UoAEEIMe+Mx9hvjkeXzv95G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnS4/BcLiyQV04Mkym0NrZHlouXSEF4BcfV+llZlYTwDFct6rrbGHN532R4vKe7oDMNzz0uVh/ej7qBolhc7NQZDgTE39Mz8lA+LxchbwOKTW47B2GvfWgKA52O9IFSmAyOTP6HVR3KL6lSqhWlWTVP+0yTJRFUScBaviYtOQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drra6xv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB16C433C7;
	Sat, 30 Mar 2024 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824801;
	bh=dJfiZr7ed3decL5IM76UoAEEIMe+Mx9hvjkeXzv95G0=;
	h=From:To:Cc:Subject:Date:From;
	b=Drra6xv/NYNVhnmfF50cJoELmMeciVxp1Mimvw+kXQr1Sr2VBYIiJouThorlTuyp0
	 9yPXranh9JyJaqXL/baJhbuNJc6zk7qIpau7HR+fV1GGVZKQcng1mwFQ4uwETD/bIn
	 tOva02/ZDIzX43lQ7Xd3hD131++q0vtn8+UxVk712bqblRQtGb9wZad69/KfBKwn62
	 BW5Gji7UvsPNLzM5KizPfMckheWn/Z8dPmRzJNj5MR4kmH3WWZ1JLNSjp811pMTTVU
	 +DnJt8xUtC3ZV+lfVy+Y/FoI19ASFfWzyRAa63IBS7vGcCUL+5gHOhPCXbfWDA4VBN
	 RW7OEf9psgKnA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 0/8]  IIO: Use device_for_each_child_scope()
Date: Sat, 30 Mar 2024 18:52:57 +0000
Message-ID: <20240330185305.1319844-1-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looking for review of these remaining patches from the earlier series.
Chances since V6:
- Rebased
- Add a precursor fix for stm32-adc to aid backporting.
 
The infrastructure being used here is now in iio.git/togreg. It missed
the merge window, but the similar DT series landed without problem.

I'm slimming this series down by taking patches that have been reviewed
but nothing yet on these ones yet.


Jonathan Cameron (8):
  iio: adc: mcp3564: Use device_for_each_child_node_scoped()
  iio: adc: qcom-spmi-adc5: Use device_for_each_child_node_scoped()
  iio: adc: stm32: Fixing err code to not indicate success
  iio: adc: stm32: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
  iio: adc: ti-ads131e08: Use device_for_each_child_node_scoped()
  iio: dac: ad3552r: Use device_for_each_child_node_scoped()
  iio: dac: ad5770r: Use device_for_each_child_node_scoped()

 drivers/iio/adc/mcp3564.c        | 16 ++++-----
 drivers/iio/adc/qcom-spmi-adc5.c |  7 ++--
 drivers/iio/adc/stm32-adc.c      | 61 +++++++++++++-------------------
 drivers/iio/adc/ti-ads1015.c     |  5 +--
 drivers/iio/adc/ti-ads131e08.c   | 13 +++----
 drivers/iio/dac/ad3552r.c        | 51 ++++++++++----------------
 drivers/iio/dac/ad5770r.c        | 19 ++++------
 7 files changed, 63 insertions(+), 109 deletions(-)

-- 
2.44.0


