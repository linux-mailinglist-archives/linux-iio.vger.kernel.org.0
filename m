Return-Path: <linux-iio+bounces-25579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D87C14F4B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACAC4244DB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 13:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AA33468C;
	Tue, 28 Oct 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o5E8UIrx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287E334C04
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658965; cv=none; b=BaxYAna6z9360spgm6mzIH5Fze+//g5HM6QIIpdGQ7GuQvFZNUQE4Al041sjMm+m1kW6jyt8xn+wgvztkPwfjzxO9TYQhngjomwspjPTiJ2BUkHwdDHHWwzIY4z5WFRkl/A4O9qSUdu+6gY6sho5gA3wJlt3kik/+wfmtYk17wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658965; c=relaxed/simple;
	bh=tKMftb6CmrNSG5/dt72pYOloqmv9eofk+dJFmp0XGp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSmT4clgUNAUmJnYr/F1CRHs2z4kyKYFZN08wX3ooP3JxXOi7pA8eQE3AFb60fnda8QDqHOgFoafecIZhfp5tISlxrL7xExSIds27ocfToua8OiGJ8E52XnGs+LER5RJLs2D/ZTYkfVBq+XCYOZ2AdlvXI+u7EM2C44S67CZVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o5E8UIrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B80C4CEFD;
	Tue, 28 Oct 2025 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761658964;
	bh=tKMftb6CmrNSG5/dt72pYOloqmv9eofk+dJFmp0XGp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5E8UIrxStzk0WQd8vp2K++9OF/RngfjfAZRgKK8W9g+gtzDdqgxCVdohO46VGXxN
	 IlYt15qiS4pQsVI/zHz2BHnDJyf8fOPN0BLO3qEBEUkMxIVgxmKIW3dkN6V4w0B4tp
	 wBu1P4aq+nUc/k5tiEStgERM/eU0Fuh5fg7nsFU8=
Date: Tue, 28 Oct 2025 14:42:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.18
Message-ID: <2025102814-extended-curtain-ae93@gregkh>
References: <aQC-twp5Op1OFRNU@emerald>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQC-twp5Op1OFRNU@emerald>

On Tue, Oct 28, 2025 at 10:01:43PM +0900, William Breathitt Gray wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.18

Pulled and pushed out, thanks.

greg k-h

