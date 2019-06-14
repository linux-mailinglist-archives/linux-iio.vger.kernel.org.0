Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C95D463E1
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfFNQUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfFNQUM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 12:20:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8542183E;
        Fri, 14 Jun 2019 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560529212;
        bh=+miqeMfSWkr4moUYw1GPgzK89cG9rhNix4a208bvm+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8qaLG22aoUH7W2zcf+EYqbggukwbugLjLyWZxukMUkndtgnt54icT8hgjuaOGrRJ
         O4kIGE/19aFlytfdvWsRaBhik8fY3OvW0GjKuHkAygAWFcVyaM6ZtLp9PB561shqVy
         I58hBLwe97fgUUV+D1oi9Q2q9NrujVPxy8kR7cYk=
Date:   Fri, 14 Jun 2019 18:20:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Anton Vorontsov <anton@enomsg.org>, linux-pm@vger.kernel.org,
        Colin Cross <ccross@android.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Sebastian Reichel <sre@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Tony Luck <tony.luck@intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 00/14] Add support to generate ABI documentation at
 admin-guide
Message-ID: <20190614162009.GA25572@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 13, 2019 at 11:04:06PM -0300, Mauro Carvalho Chehab wrote:
> Greg,
> 
> As promised, I'm resending the patch series with adds the Kernel ABI to
> Documentation/admin-guide.
> 
> Those patches are basically the version 3 patchset I sent back in 2017,
> rebased on the top of linux-next (next-20190613), and with some fixes
> in order for it to work.
> 
> - The 4 initial patches to fix some ABI descriptions that are violating 
>   the syntax described at Documentation/ABI/README;

These 4 are now applied to my driver-core tree, thanks.

greg k-h
