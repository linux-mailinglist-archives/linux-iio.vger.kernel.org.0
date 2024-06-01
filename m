Return-Path: <linux-iio+bounces-5578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2088D702B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F51C21646
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 13:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7E14F9ED;
	Sat,  1 Jun 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2j0EAKL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBA8C04;
	Sat,  1 Jun 2024 13:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248117; cv=none; b=X8XBZBgE8CNt7AalZIrWLp2crBKcZS8MQWtw0GrcGj++Jf0gIYpOF8Jijk5VdyC5E18RbfZX1+pPMJI8VVfS+Q6eHsQFGMx1oc4y8HOq6hm9A8pYqKyQ0CYRrYpVxpYkopSreQqNL/fAyWLO8R9ZFqKvqXPheR7KmfV8o+Y9Osk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248117; c=relaxed/simple;
	bh=l/he8j/750/A4n4DZmFkdOFTh7dOKEIKzSspnPzjkmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfFC5yF579LqrpPlodRhWgEkGNfmTP1tc7s6BFBLjzzFSCgSLErTrcXS3ZJhwAs381AtXBZ1+RP1abSc6cPLnPNdzD5T5sf3AGfLCQk9xa/g+7Z6iNx2d4a2YEkckmaWmHt3XkbTe/li+qM2q46xIsJ+f78FvPPY+aJ+7JnoT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2j0EAKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF7CC116B1;
	Sat,  1 Jun 2024 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248116;
	bh=l/he8j/750/A4n4DZmFkdOFTh7dOKEIKzSspnPzjkmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l2j0EAKLNyrEfvBk0792+gT4S/9JFEBBMC3Z6s5dsaU0LxgZThBqtt/2dwwWv3nt/
	 Ifp4FCbyiWZtpHpLXDMlPfQf5hJoeCMsprR9yi7cmRHSEmxmqnP2VoI6U2O1k96iy7
	 6eyE/pT80dOB1sN89vIH3HVHxl7iYY3uNrxSKlzvI0NDR/2GT6oVSiwqYyNL1O5def
	 rm16sAktF8U9uMT7GohNXGVCyKIyBz5y+ZqzBxtKQIaC2QWd5EMOrjzHNXOclp6u3L
	 UgQ9qQOBQuTnB/FxrwgSzUCI+XBDL48/2UBANtEApldLlERKBxEMP6tF73WQCRAzqL
	 oUYcQLMSknL3w==
Date: Sat, 1 Jun 2024 14:21:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH] iio: inkern: fix channel read regression
Message-ID: <20240601142147.3ac40207@jic23-huawei>
In-Reply-To: <20240530074416.13697-1-johan+linaro@kernel.org>
References: <20240530074416.13697-1-johan+linaro@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 09:44:16 +0200
Johan Hovold <johan+linaro@kernel.org> wrote:

> A recent "cleanup" broke IIO channel read outs and thereby thermal
> mitigation on the Lenovo ThinkPad X13s by returning zero instead of the
> expected IIO value type in iio_read_channel_processed_scale():
> 
> 	thermal thermal_zone12: failed to read out thermal zone (-22)
> 
> Fixes: 3092bde731ca ("iio: inkern: move to the cleanup.h magic")
> Cc: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Hi Johan,

The documentation for this function unfortunately says 
* Returns an error code or 0
so not surprising this went wrong.

All those docs should be dragged alongside the implementations
to make it easier to spot errors and seems we need to do some
fixing up of those docs in general :(

In meantime, Nuno please take another look at these and see if
we have additional problem cases like this.  Given the patch
queue I have and a busy few days it will be a while before I
get to it but I'll try and take a close look soon as well.

Longer term, in my view the readability and chance of bugs
is reduced, but churn always introduces the possibility of
issues like this in the short term :(


Jonathan


> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> Someone should re-review the offending commit so that there are no more
> of these subtle regressions that are bound to happen when people use
> cleanup.h to save a few lines of code at the cost of readability.
> 
> Johan
> 
> 
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 52d773261828..485e6fc44a04 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -721,7 +721,7 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  			return ret;
>  		*val *= scale;
>  
> -		return 0;
> +		return ret;
>  	} else {
>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)


