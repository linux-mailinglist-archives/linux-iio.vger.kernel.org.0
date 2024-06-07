Return-Path: <linux-iio+bounces-6035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE7900C3B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 21:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE94B23EE4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 19:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9EF61FF6;
	Fri,  7 Jun 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpBqq42w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641C13AD1D
	for <linux-iio@vger.kernel.org>; Fri,  7 Jun 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787193; cv=none; b=Cp5HzTPdZnghxIwDp9u0iwTNmJK3QEW5bPiX9hgwq3uZ4KdlIXrLxgOBIt2cU34x4wvuyiObcJ/xs4oHy08anT33P2UdPrMs1EziRat/eFLmAXILFCQd2HIptjoLG4/guGnET4IvWwbZLHRj9LCI7jpZoCq0o0jq9O5h8/vtrqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787193; c=relaxed/simple;
	bh=8uN4RzlTAlE/ZqYzN1n47yc3/zI1VapggYn8tsX17dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1gspDG1qTKmXbwxYV1oJ87zeEzMEtfrd00PkR8rvDNxORwVzjYyQjGMmjpZi/jwhGxYihyqBCqKPwAcPFq4WnusmB7dHf3ABJL+JGlwVjGSMvQQawn39AaWdVPo3Kb7ApCra3rRiNXkQgsrBU2aTiIZ4yL2IAaLRRoXtuA92jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpBqq42w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E229C2BBFC;
	Fri,  7 Jun 2024 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787192;
	bh=8uN4RzlTAlE/ZqYzN1n47yc3/zI1VapggYn8tsX17dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpBqq42wVYcPdBOv5bS190OwVaZPmkM5kjtee2K2+gZWtP20ZH4kiQzpES5hOBjmI
	 BKm70ECpGDgnoz3g2jJigVVDEyXkR98bnoD97jO6gOzbIMKKx3/Lh6ecKhU+aDbosc
	 /0UmPToyn4kiYwkGoj6iFeghyS0HG12HqISTzXa8=
Date: Fri, 7 Jun 2024 21:06:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First round fixes for IIO in the 6.10 cycle
Message-ID: <2024060721-mantis-snide-d160@gregkh>
References: <20240604200632.6af3f262@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604200632.6af3f262@jic23-huawei>

On Tue, Jun 04, 2024 at 08:06:32PM +0100, Jonathan Cameron wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.10a

Pulled and pushed out, thanks.

greg k-b

