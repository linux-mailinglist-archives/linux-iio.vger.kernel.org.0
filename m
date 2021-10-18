Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C299431027
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 08:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhJRGJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 02:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRGJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 02:09:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D276560FDA;
        Mon, 18 Oct 2021 06:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634537223;
        bh=u907fzJGCsW/K6d5JyjX2Ui9UtSyEQKwnAT2EYW7Pp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvS45Rt8c1MYzmcQOJ5ZL+Xnid14XHbZ4nQN1OSvV7GFJK68abA56od933BXZuybZ
         XiE9Uxl790ir16SIGctONe0KXZA+bejlOgqGrAemg9RCYUIWqlmxZz/lMsjo0iKm4M
         eME4XzzKXf0UIbGEd8waNVUYj9CcqV9FGxhMn/jU=
Date:   Mon, 18 Oct 2021 08:06:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter/counter-sysfs: use sysfs_emit everywhere
Message-ID: <YW0PAq8nB6FcLwZd@kroah.com>
References: <20211017190106.3472645-1-david@lechnology.com>
 <YWyyzmNGxWKyKiAD@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWyyzmNGxWKyKiAD@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 08:33:34AM +0900, William Breathitt Gray wrote:
> On Sun, Oct 17, 2021 at 02:01:06PM -0500, David Lechner wrote:
> > In the counter subsystem, we are already using sysfs_emit(), but there
> > were a few places where we were still using sprintf() in *_show()
> > functions. For consistency and added protections, use sysfs_emit()
> > everywhere.
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: David Lechner <david@lechnology.com>
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Thanks, want me to take this directly on top of the previous pull
request?

greg k-h
