Return-Path: <linux-iio+bounces-17383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506DA75BBA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41882188B4C0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0761DE4E0;
	Sun, 30 Mar 2025 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6s5wsIo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB88F5B;
	Sun, 30 Mar 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743358307; cv=none; b=W1YdUixN01sUa1r3EcxNeb+odgN4tGl9x6LaZCE/sT8saWEwviO4XPGDNObB0Tz3VQ+cRVSblpzNnnL3+ZEOnKixw0cSnKu97Tyi9X2E8ejOMIbE/PqyZh/dk0zgzd6oHn2whsxyNh2+sF5Yr2776Ysnkaf318ArWr5MA75ncEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743358307; c=relaxed/simple;
	bh=4HDFXcoZxGwUNwcERXxyDzyzx2MdPQVoyBaEIey3EOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3463yjUDpFpo+05olEeYGmL875WW0/vDoEkNRnbgvUHXMZUc/wEFu8zeD5kp58MxVzeeVrrvRiKnWQORFt05UWmBTRdOh4YMpOgUpqoAhDPLWktew/q8gBXSoEyId96WHvcr/zNJA9eOTQIr/Ygu0GxGGbYlA8z7aIeLSlt39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6s5wsIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71B8C4CEEB;
	Sun, 30 Mar 2025 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743358306;
	bh=4HDFXcoZxGwUNwcERXxyDzyzx2MdPQVoyBaEIey3EOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k6s5wsIoPaFjbaSUwR26H7uuyoD1bHfLN45Wxqv27MrhOPm7pUJ7V6A8HAOmDzL8r
	 Jn7ihEGGX+RU/plRpnIvjXACfB/IVFOA5qTBDrouUqz8bmkC9rjisQvCFybzHlaPPT
	 ANRkn7ZBOoeVekTTBgQNJGN83cnhteyHeKQ82mMss8oI8B4wwzykSjt2p7N5gOMOQy
	 13MserMavplFyVmviVH8evoW4B/MfnSnXkX38EDnTyRA8fh25BrHv+r/ENigHyG0sa
	 2R1CBdmQSJeaAFXa6dHSBbPwfSWJLbgcXJZ593VQ6mpvP5hH1+RApJ5qZjL22ixuOq
	 E/Y4ekCDLXUoA==
Date: Sun, 30 Mar 2025 19:11:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Benson Leung
 <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iio: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20250330191137.037735d3@jic23-huawei>
In-Reply-To: <Z9qKyZsH4akWG2q3@google.com>
References: <Z9lE6IVDeC5lnChN@kspp>
	<202503180840.77F2F47DE8@keescook>
	<Z9qKyZsH4akWG2q3@google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 09:13:45 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Tue, Mar 18, 2025 at 08:42:41AM -0700, Kees Cook wrote:
> > > +	((struct ec_params_get_cmd_versions *)buf->data)->cmd = cmd;
> > > +
> > > +	ret = cros_ec_cmd_xfer_status(ec_dev, buf);
> > >  	if (ret >= 0)
> > > -		*mask = buf.resp.version_mask;
> > > +		*mask = ((struct ec_response_get_cmd_versions *)buf->data)->version_mask;
> > >  	return ret;
> > >  }  
> > 
> > Since "params" is used twice, I'd say do like the other patch and assign
> > it to a new variable:
> > 
> > 	struct ec_response_get_cmd_versions *params = buf->data;
> > 	...
> > 	params->cmd = cmd;
> > 	...
> > 		*mask = params->version_mask;  
> 
> Not a pushback for introducing new variables.  FWIW, it uses "param" and
> "response" only once.

Given that reply I'm assuming Kees is fine with this.

Applied.

Thanks,

Jonathan


