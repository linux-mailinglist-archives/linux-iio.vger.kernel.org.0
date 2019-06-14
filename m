Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71E56463C8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFNQQV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfFNQQV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 12:16:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFD12084E;
        Fri, 14 Jun 2019 16:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560528981;
        bh=nc6Gu5WBuukhttllfbWpI15h3ZGPSrpGNeXbIbz0ozA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3HqbykgRzdLv007Fa8DMJ6Kl9yBBdM5dM7hEe6w6/BmYne48hzMVGPojn41NRg+X
         XFl3RtVlQ6wQmWCQ26AzbUtsa1a3EzKI/xREY4FW1fTjzKYCyGiqINBlk2M+nLJMQy
         UD3crjifc+POF6aRF0+jbAnSYZenE2AX1jpaSB1w=
Date:   Fri, 14 Jun 2019 18:16:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-iio@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/14] ABI: fix some syntax issues at the ABI database
Message-ID: <20190614161618.GA23190@kroah.com>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
 <b908fc6555df8cae3e4c734b2d5f6284c46a5f14.1560477540.git.mchehab+samsung@kernel.org>
 <1ef7b765-da34-c65b-a226-f17969935ce2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef7b765-da34-c65b-a226-f17969935ce2@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 14, 2019 at 05:20:29PM +1000, Andrew Donnellan wrote:
> On 14/6/19 12:04 pm, Mauro Carvalho Chehab wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> > index bbbabffc682a..fc7c6f7c21b3 100644
> > --- a/Documentation/ABI/testing/sysfs-class-cxl
> > +++ b/Documentation/ABI/testing/sysfs-class-cxl
> > @@ -1,6 +1,6 @@
> > -Note: Attributes that are shared between devices are stored in the directory
> > -pointed to by the symlink device/.
> > -Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
> > +Please notice that attributes that are shared between devices are stored in
> 
> Would prefer "Please note" over "Please notice".

Now changed, but that's a minor grammer thing, both are correct. :)

> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>  # cxl

thanks,

greg k-h
