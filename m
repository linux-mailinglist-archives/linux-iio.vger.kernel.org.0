Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDB1957C9
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 14:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgC0NRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 09:17:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:21831 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgC0NRg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Mar 2020 09:17:36 -0400
IronPort-SDR: L3FMgNOVANyHEQQiPzXQhFrbkzFIQCjoWtIX2Qg8y4aH782rDqh01j72yvoIvk+LM+Ikdyrff1
 kDfLyNJUXXXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 06:17:33 -0700
IronPort-SDR: foPMD2FQZikaok3kV3miyDyHBAn9vtjKjrQOARBpQeXz1M1HoYXgX+pifcg3RUnnUJWKPYwPWZ
 kXueVak/Ae3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,312,1580803200"; 
   d="scan'208";a="394373114"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2020 06:17:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jHore-00DQJZ-2a; Fri, 27 Mar 2020 15:17:34 +0200
Date:   Fri, 27 Mar 2020 15:17:34 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200327131734.GV1922688@smile.fi.intel.com>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-3-sravanhome@gmail.com>
 <20200327075541.GF603801@dell>
 <a6098b6a-2b2f-5279-f9fc-85201b9aabde@gmail.com>
 <20200327102221.GA3383@dell>
 <a679aba5-4cfb-1b6c-8cb0-dab3a644f3e7@gmail.com>
 <20200327112523.GC3383@dell>
 <45f68c40-8e50-e0a2-a89a-b5a164d6b75c@gmail.com>
 <CAHp75VcAq-CwsXccbLVxEwGjZjNhdcbMyM-Y-=SEbmexBidCHw@mail.gmail.com>
 <0f344b03-ce5e-4a31-5268-6db4266b352e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f344b03-ce5e-4a31-5268-6db4266b352e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 02:03:30PM +0100, saravanan sekar wrote:
> On 27/03/20 1:56 pm, Andy Shevchenko wrote:
> > On Fri, Mar 27, 2020 at 2:41 PM saravanan sekar <sravanhome@gmail.com> wrote:
> > > On 27/03/20 12:25 pm, Lee Jones wrote:
> > > > On Fri, 27 Mar 2020, saravanan sekar wrote:
> > > > > On 27/03/20 11:22 am, Lee Jones wrote:
> > > > So Andy has reviewed, but you still don't have him on Cc?
> > > Sorry one of his hint made me removed him in CC unknowingly.
> > > 
> > > "For the future, hint:
> > >           scripts/get_maintainer.pl --git --git-min-percent=67 ..."
> > > 
> > Perhaps I have to elaborate. The above hint for the initial submit.
> > Then the rule of thumb: Include reviewers into Cc (to the patches they
> > have reviewed), because you can't know their intention and maybe they
> > want to follow a development.
> Thanks for more details. Between Lee has not recommended "forward
> declarations", the review comment
> you gave on my V1 patch (more info on previous email). Hope you agree with
> the same.

I think so.

-- 
With Best Regards,
Andy Shevchenko


