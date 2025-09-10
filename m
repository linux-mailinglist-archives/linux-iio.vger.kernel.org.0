Return-Path: <linux-iio+bounces-23963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F48B52046
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D813C46502F
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346F92BE7A1;
	Wed, 10 Sep 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R16YAGm2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A9329F2D
	for <linux-iio@vger.kernel.org>; Wed, 10 Sep 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529091; cv=none; b=B06g3V0Us7lpbFTnM9UURaaKikE/rD0TIzaHDEw7mzRnFmtRYpY9pnmc1PnvsGkQFz0Rw6tAuWUJ3wyLh+CXof1CWxwaIqsBdX0ZAfnULsdz5JvfheWEDSOjA6+Wj643gNfPBbdnyAcpGykgRnSr+IW6mX5FHgxYnEBY6sJwjtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529091; c=relaxed/simple;
	bh=jEl96WAQcjscHUpmhx6/uB3USM2lvkkqR2NlB5vp0tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nfh1fRLHRdIDDPE03Ilg3rKBjOVINrEn1PXmJdnEqCV53BTKS9mR+gxU95ecHsGKd2Nry8S4L2hBNjY9BNhucwBi25MDuypfgDUGEfkZEX+F3AYojHYcDZJ+Id+7jGSogN3VdvyTctfe3NxDBwTC2o4KQWPsXG8gM1rs+DEaBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R16YAGm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E6C4CEEB;
	Wed, 10 Sep 2025 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757529090;
	bh=jEl96WAQcjscHUpmhx6/uB3USM2lvkkqR2NlB5vp0tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R16YAGm2acRXL6AwYbgxwSlkV7lfBPs0dTD/Qn4kADbgLuraaHxx2SAHmyaWSc6lO
	 PdP8OdlmgaEBXI1gbcpUWOODDD294NPWOaWy9g/2Ebyr9W6QB/+QDfpk9bX0VoVCLe
	 bcJcCLT7H2kSxNlZGv+MNtDOw3QnTvQkCA/vHFlan+3XhMqn423l8lXf1u+5btIIxh
	 wpNgLdWETxzT25rCFZk5W23ZigQ2buPQZszPwMqAuzMo0VJn+SZQCb4bmC7Qulv7F6
	 CQeM2hNdt8pg86uvsb28JpgnAogPj6/Qwnr5I0ftnUgxRvSyc8JG65hY/HrJzsj5Ye
	 ECRgO8looUggA==
Date: Wed, 10 Sep 2025 19:31:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Valek <andrej.v@skyrain.eu>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan
 <puranjay@kernel.org>, Kessler Markus <markus.kessler@hilti.com>
Subject: Re: [PATCH] drivers: iio: accel: fix ADX355 startup race condition
Message-ID: <20250910193123.0718c21c@jic23-huawei>
In-Reply-To: <20250909085528.68966-1-andrej.v@skyrain.eu>
References: <20250909085528.68966-1-andrej.v@skyrain.eu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 10:55:28 +0200
Andrej Valek <andrej.v@skyrain.eu> wrote:

> From: Valek Andrej <andrej.v@skyrain.eu>
Just noticed the part number in the title is missing the L.


