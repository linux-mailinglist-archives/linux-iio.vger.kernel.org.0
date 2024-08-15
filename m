Return-Path: <linux-iio+bounces-8509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D716953BFF
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 22:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0981C22E87
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 20:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65816D9B9;
	Thu, 15 Aug 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moF8CHZN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C616D9A9;
	Thu, 15 Aug 2024 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723754496; cv=none; b=mnWgbN092xOrdWbU3qMuk09YJQ1/+BFQzuCwqAvi52CW0fPkDLMGt5jACdvy+8Mxng7OtDc/CR5wqSp1CVwGwoF+GxBN773QYwJ8pinlAKAkWxMlRcA5dAbJMnic9EI1F0jqBvXCfDh5KZskkV050Iohe66vunWNY5DeCXLX6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723754496; c=relaxed/simple;
	bh=3a9dcyvFHc8YXBqSB3+TQ/Rts7IeevLXpa478g+84LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMZwc93LbHtnZIWc1TF1H1FwjXaLCxx6BpwisuyDXYDpiM+CewIqpdniHZaNpzsaN3uYbqZkTZ59bkqCpkM3bCv4J6xaWyaGYh7Q4K24+A0TjGK9v7I1WvYlPqcq+F8QWaGuWxjQY/YaNryGUn3sJ4U5UxRiZp4GnXkpwmSp2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moF8CHZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EE4C4AF13;
	Thu, 15 Aug 2024 20:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723754496;
	bh=3a9dcyvFHc8YXBqSB3+TQ/Rts7IeevLXpa478g+84LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=moF8CHZNNnutHo1SViyxGYVNVeWda3hEiljFVxS2M707ecxkAlcyHEDUEd1CMzpzb
	 Fh1Kq+AsWbGzXYpZmPENwoZUOqnhygt4YrjPAeDfcV8cKVbWtSTX8SD+QN5L6rkPFG
	 i58v9AoXw6MzUbTCBjcSw/a5f1h8WOZErWgf5naQ3AxVfSGUkZLps8Guzkaw89DTfO
	 YtlOIBUP1mzBGz1wxwsh3aYy7wVfCtC26FsOXmYoG+2a/yi7oZgTVNahDOqS3ABN8x
	 /aCizCGqXCavcMt/x4Aj4h2NFl71mSaSXFWjq4FhbniM5W3Z3AQTbR54it8c6FHX39
	 O6EmKc3wlLv6g==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Rayyan Ansari <rayyan@ansari.sh>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Robert Yang <decatf@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: (subset) [PATCH 0/3] KX022-1020 accel support + inertial sensors on msm8226-microsoft
Date: Thu, 15 Aug 2024 15:40:47 -0500
Message-ID: <172375444809.1011236.4214325982045464199.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714173431.54332-1-rayyan@ansari.sh>
References: <20240714173431.54332-1-rayyan@ansari.sh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 14 Jul 2024 18:33:02 +0100, Rayyan Ansari wrote:
> The following patches:
> - Add support for the Kionix KX022-1020 accelerometer
> - Add the KX022-1020 accelerometer and AK09911 magnetometer to msm8x26
>   Lumia devices
> 
> Thanks,
> Rayyan
> 
> [...]

Applied, thanks!

[3/3] ARM: dts: qcom: msm8226-microsoft-common: Add inertial sensors
      commit: 18042ad9dfd01d247407bb0721c6338eb8a9a2ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

