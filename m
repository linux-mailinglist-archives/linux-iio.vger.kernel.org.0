Return-Path: <linux-iio+bounces-16690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7E2A5A3D6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2A71891F17
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AE236A7C;
	Mon, 10 Mar 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4SFELSS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9723315A
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635142; cv=none; b=Ye14cGTUhKg80s8Dnpe0KlqYOoGy00DxirCDYOr7ilfAQ3sT6LeBYvG4yrRVGj3Sj24pA7P0ikG/GfNkz01s63t4cXOTO5v/GliXykxjPkHrTKe23gUAP1mgkyAZBJX2N8bi2xGBWA8MJFe2eZdk9J/HkvTGfQJL+hFFaPn7vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635142; c=relaxed/simple;
	bh=jVos7i5igW5IuX3DPvgb/WOP7d0ArL3YFgPQSGLFfDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtvKUa7E543zzoZXs1o+NfEBL8seuedzpTuYCb+MNUZvwO5xn6S74/huPE88JM7ZdzbG8WsBwz+QHTKLiJuS1Bw01Cm6d3xPoUFKUTJhTRpOo+yoY4y+eSCLUVEQIkZI3UsgoFVdHfkWfuWSbRTvPryYJjs7C4/c5y70O421arg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4SFELSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210EAC4CEED;
	Mon, 10 Mar 2025 19:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635142;
	bh=jVos7i5igW5IuX3DPvgb/WOP7d0ArL3YFgPQSGLFfDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4SFELSSqKcXx7f7Dm/lGpPOXliZjYo2jj1RcOV1UweXaGZaoiCdo5TkQ3ah8VSsl
	 M2ZWUZk5xG3zPzHMnSzTgySixnGsiNoSPUAgYIN79ZpCf7ih9eW/9HHqVdD3mFBAku
	 m4+uY45LNK5Nd0Bj/Gl3Hi9MYRCW5b0ntfOSRu3E5/D9bKszL53SNb9asRmSrkO0gW
	 Ka7fX5Fr3c1VE4mYTR6DRbo5CCMVieAsaN0ovZB1BhOrZhRgm1VZNkDRzyOX4RdL52
	 Anm0J2W4aEEfQq/fobqtFW/03bN92phHY4dHP4JLPrz8dBWOK1DK4XFJ7MxQvqpxH8
	 e4knfpTQMzODg==
Date: Mon, 10 Mar 2025 19:32:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Prince Kumar <855princekumar@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: Proposal Discussion: ADE9113 IIO Driver Development for Linux
 Kernel
Message-ID: <20250310193215.0f091dc0@jic23-huawei>
In-Reply-To: <CAMmuoAJy_GPL-7tfbrgH9U4T4UvUiDoHozw67BqadoV_nAJXog@mail.gmail.com>
References: <CAMmuoA+1Qi2qnF64nmHobL6hSFdf6GUrX=BjZ=0aGULu75b3GQ@mail.gmail.com>
	<20250309162637.6937c7c6@jic23-huawei>
	<CAMmuoAJy_GPL-7tfbrgH9U4T4UvUiDoHozw67BqadoV_nAJXog@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Mar 2025 10:33:44 +0530
Prince Kumar <855princekumar@gmail.com> wrote:

> Hi Jonathan,
>=20
> Thanks for your valuable feedback! Your insights are really helpful in
> refining my approach and ensuring alignment with best practices.
>=20
> 1. DT Binding Flexibility:
>    I initially considered making the DT binding adaptable for similar
> SPI-based ADCs to potentially support minor hardware variations with
> minimal changes. However, your point about maintainability makes
> sense, and I see that most existing bindings tend to be more specific.
> I=E2=80=99ll revisit this and reconsider whether a part-specific approach
> would be more appropriate. If there are examples of flexible but
> maintainable bindings worth looking into, I=E2=80=99d appreciate any poin=
ters.

The problem with increasing flexibility is that in usually means
more complex matching rules (see allOf/oneOf statements in existing
bindings) to ensure we require what is needed for a given specific
device.  Those are a lot harder to read than separate files but do
make sense if there are only one or two minor differences between
a small number of devices.

>=20
> 2. MCU-Assisted vs. Direct SPI:
>    This was more of an exploratory idea rather than a fully defined
> plan. My initial thought was to assess whether offloading certain
> operations to an MCU (e.g., pre-processing or buffering) could offer
> benefits over direct SPI communication with the Linux system. Given
> that this isn=E2=80=99t a typical approach, I=E2=80=99ll take a step back=
 and ensure I
> properly evaluate the feasibility and trade-offs before including it
> in the proposal. If there are existing implementations that explore
> similar optimizations, I=E2=80=99d be keen to study them.

There is SPI offload logic in the kernel that will merge this cycle.
(it's in the IIO tree on git.kernel.org togreg branch

Expanding that to MCU based handling (all implementations are currently
FPGA based) would be an interesting project. May be too complex to fit
in the timescale of a GSOC.  Perhaps a valid stretch goal though if the
rest falls in place quickly.

Jonathan


