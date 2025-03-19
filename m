Return-Path: <linux-iio+bounces-17083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B60A6879D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 10:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E10E188D6B4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427A72528EE;
	Wed, 19 Mar 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ins+CBjh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16A32517B1;
	Wed, 19 Mar 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375630; cv=none; b=moAaetti3olIdy4zmLzDAFC+Bx8ECKOGNSh7B+KIbQwYBxgK/SIUDjVsUF+vlOKlyjsdIgsgp9mkBUqBQDNTDs0MPRSYGGFd+BOQkWUd7LcymlgOB5m/6T2M3P9BABT/E8dVXefHsyPKgqRsjlXw6V1lMLGwnHUXrpbtQnJG5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375630; c=relaxed/simple;
	bh=LkRAk+MpcTjxCqacaPf3nABggbIXUnseqT+2cZlt2gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZx29PUza85dfaxglHAxgADVeTyuZiKc0jOkQ5TstpsqalLGj+vNp67Ln7UUxNsq7Zm25Mku75PU21X/GaPZ03o6kEcOJYVWsnHiDRcV9fz5qVnRpjRNKszK9N4tfc5Pq633FNorvwuznILfalwcYmQ4XvT6FwYZk5mQIEApaGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ins+CBjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C538AC4CEEF;
	Wed, 19 Mar 2025 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375629;
	bh=LkRAk+MpcTjxCqacaPf3nABggbIXUnseqT+2cZlt2gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ins+CBjhIsaybuJZQTWNJ1FDFqF37YZou0LhP1Qz+I0cdULeAHmzzAsH3WFeGQk1S
	 ImSwDAYi9NIpidz1tbEcOuH4H79kuqBDCjN6itLBqWc6hvqJ2wD2/gn7iSvbF0KM7r
	 OimKsyOsjYnjU6ZYLDnCVbKBUH6uWXlgnvoTJYYqWZDr6d5Km+eIaTh5AhHCzz+Chb
	 0zc6sN7f+CbUIReasmT7cjUuJrZyk0ZL2i92Fowac2Yn+O62ySmXs3CmE5WIiQzGoa
	 uGyJjGR8qy++Jrn+HAvaBHDS+VqT2xm0cVBnXINjq02b1gYyWt6YAOajJ1LxIWkHgv
	 Iy+xCe8fbLmyw==
Date: Wed, 19 Mar 2025 09:13:45 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iio: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9qKyZsH4akWG2q3@google.com>
References: <Z9lE6IVDeC5lnChN@kspp>
 <202503180840.77F2F47DE8@keescook>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202503180840.77F2F47DE8@keescook>

On Tue, Mar 18, 2025 at 08:42:41AM -0700, Kees Cook wrote:
> > +	((struct ec_params_get_cmd_versions *)buf->data)->cmd = cmd;
> > +
> > +	ret = cros_ec_cmd_xfer_status(ec_dev, buf);
> >  	if (ret >= 0)
> > -		*mask = buf.resp.version_mask;
> > +		*mask = ((struct ec_response_get_cmd_versions *)buf->data)->version_mask;
> >  	return ret;
> >  }
> 
> Since "params" is used twice, I'd say do like the other patch and assign
> it to a new variable:
> 
> 	struct ec_response_get_cmd_versions *params = buf->data;
> 	...
> 	params->cmd = cmd;
> 	...
> 		*mask = params->version_mask;

Not a pushback for introducing new variables.  FWIW, it uses "param" and
"response" only once.

