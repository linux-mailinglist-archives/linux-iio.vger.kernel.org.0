Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16624995C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 11:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHSJbt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 05:31:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:6347 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgHSJbs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Aug 2020 05:31:48 -0400
IronPort-SDR: xl7tFlJVo1u+8NsAVDxBs7J87a6PDhXO6zFe9L/74oABnElySxxJxf7GKPgAZmXcwxCt7aOXtA
 LLdUeB4QdixA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="156145907"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="156145907"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 02:31:47 -0700
IronPort-SDR: KcYYofNl8Lq06snYEvg+e1pLJ9t2x0pWy5+yYL30Q0/rQZf0DELbUCRdSMIf3//398c4qQQ+tp
 tPhDeiPAuAuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="327032676"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 02:31:44 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k8KAi-009qDg-0R; Wed, 19 Aug 2020 12:14:16 +0300
Date:   Wed, 19 Aug 2020 12:14:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
Message-ID: <20200819091416.GX1891694@smile.fi.intel.com>
References: <20200817170535.17041-1-brgl@bgdev.pl>
 <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com>
 <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
 <20200818082500.GB1891694@smile.fi.intel.com>
 <CAMRc=Md5yrgxnPf=qwKYhwHACcq-XeKOKZ76OwYdMGO8SgYmzQ@mail.gmail.com>
 <20200818171046.GU1891694@smile.fi.intel.com>
 <CAMRc=MfmmRweZ_WBkqA_FHVoTZ5KxNwyFLjwpypG5c=K9ki8XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfmmRweZ_WBkqA_FHVoTZ5KxNwyFLjwpypG5c=K9ki8XA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 18, 2020 at 08:13:10PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 18, 2020 at 7:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 18, 2020 at 06:27:12PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Aug 18, 2020 at 10:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Aug 17, 2020 at 10:02:05PM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> > > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

...

> > > > > > > +static struct devres *to_devres(void *data)
> > > > > > > +{
> > > > > > > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct devres),
> > > > > > > +                                                 ARCH_KMALLOC_MINALIGN));
> > > > > >
> > > > > > Do you really need both explicit castings?
> > > > > >
> > > > >
> > > > > Yeah, we can probably drop the (struct devres *) here.
> > > >
> > > > void * -> u8 * here is also not needed, it is considered byte access IIRC.
> > > >
> > >
> > > Actually it turns out that while we don't need the (void *) -> (u8 *)
> > > casting, we must cast to (struct devres *) or the following error is
> > > produced:
> > >
> > > drivers/base/devres.c: In function ‘to_devres’:
> > > drivers/base/devres.c:41:21: error: returning ‘u8 *’ {aka ‘unsigned
> > > char *’} from a function with incompatible return type ‘struct devres
> > > *’ [-Werror=incompatible-pointer-types]
> > >   return ((u8 *)data - ALIGN(sizeof(struct devres),
> > >          ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >         ARCH_KMALLOC_MINALIGN));
> > >         ~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Of course, you have to drop u8 * casting as well.
> >
> 
> Yes, of course. Duh

With this addressed (and don't forget to remove also unneeded parentheses),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks!

-- 
With Best Regards,
Andy Shevchenko


