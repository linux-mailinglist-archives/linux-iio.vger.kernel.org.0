Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A00E4BDDDD
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 18:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiBURGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 12:06:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbiBURGC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 12:06:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3E25EAB;
        Mon, 21 Feb 2022 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645463137; x=1676999137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=B48VunkfltI7ORfOv5PjM60iRaxmuGfwDrhLF7yQ2xQ=;
  b=kVe08nYm24vWbahF6Ll0Ns9IHpVJONllLQ1gokslMOz4ZwdZLXW14Bz2
   6J443jlbT0wCO48yagQKNM1nfEfVSb2+TrCI74vNamgdeFC8g5ixUAIxI
   5irMDYeY77rycJrm/qpASNL+jh/uCBJOwSM6Mx6BqcW3l8cBnfy6ydRS+
   sahI7OhUMeZJWKjf6zMS5nufydnjmacQkMOUYD14xM5N/ngQo51uv/HOz
   zqPyMbwTqeRDQoAKJS5A6LmqEEy8ojS3sjYOnLDszl36EGN9ANTjPdsUb
   /7B3bl6ngy+3Oz+CERXdElst4iWy4I5j4GSrHqriCWNMBbseSrblRzlHQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="231512018"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="231512018"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:05:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="573163340"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:05:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nMC74-006rPO-Te;
        Mon, 21 Feb 2022 19:04:38 +0200
Date:   Mon, 21 Feb 2022 19:04:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <YhPGJqEuTQ3TBy46@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YgD91zg4L1S5KH5k@smile.fi.intel.com>
 <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
 <Ygpd7pebiuGuB8nT@smile.fi.intel.com>
 <11bd63bc07fd406bfa31bdc38b597011cc9312cc.camel@gmail.com>
 <YhImsJidUu2fMKgu@smile.fi.intel.com>
 <3f2523127eb320a9825e272353afea9673e5d003.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f2523127eb320a9825e272353afea9673e5d003.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 21, 2022 at 01:48:12PM +0100, Nuno Sá wrote:
> On Sun, 2022-02-20 at 13:32 +0200, Andy Shevchenko wrote:
> > On Fri, Feb 18, 2022 at 02:51:28PM +0100, Nuno Sá wrote:
> > > On Mon, 2022-02-14 at 15:49 +0200, Andy Shevchenko wrote:
> > > > On Mon, Feb 07, 2022 at 09:19:46PM +0100, Nuno Sá wrote:
> > > > > On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:
> > > > > > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:
> > > > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > > > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:

...

> > > > > > > > > +       ret = kstrtou16(buf, 10, &val);
> > > > > > > > 
> > > > > > > > In other function you have long, here u16. I would expect that
> > > > > > > > the types are of the same class, e.g. if here you have u16,
> > > > > > > > then there something like s32 / s64.  Or here something like
> > > > > > > > unsigned short.
> > > > > > > > 
> > > > > > > > A bit of elaboration why u16 is chosen here?
> > > > > > > 
> > > > > > > Well, I never really saw any enforcement here to be honest
> > > > > > > (rather than using stdint types...). So I pretty much just use
> > > > > > > these in unsigned types because I'm lazy and u16 is faster to
> > > > > > > type than unsigned short...  In this case, unless Jonathan really
> > > > > > > asks for it, I prefer not to go all over the driver and change
> > > > > > > this...
> > > > > > 
> > > > > > This is about consistency. It may work as is, but it feels not good
> > > > > > when for int (or unsigned int) one uses fixed-width types. Also
> > > > > > it's non- written advice to use fixed-width variables when it's
> > > > > > about programming registers or so, for the rest, use POD types.
> > > 
> > > Ok, going a bit back in the discussion, you argued that in one place I
> > > was using long while here u16. Well, in the place I'm using long, that
> > > was on purpose because that value is to be compared against an array of
> > > longs (which has to be long because it depends on CCF rates). I guess I
> > > can als0 use s64, but there is also a reason why long was used.
> > > 
> > > In the u16 case, we really want to have 2 bytes because I'm going to use
> > > that value to write the dac code which is 2 bytes.
> > 
> > Okay, that's what I want to hear. If it's indeed goes to be a value to the
> > register, then it's fine.
> > 
> > Perhaps a comment?
> 
> I guess you mean to have a comment to state that here we have fixed
> size type (as opposed to long, used in another place), because we
> directly use the value on a register write?
> 
> Asking it because I'm not planning to add comments in all the places
> where I have fixed size types for register read/writes...

Thinking more about it and now I'm convinced that using the value that goes to
the register in ABI is bad idea (means that user space must not care about the
size or contents of the hardware register and should be abstract representation
of the HW).

OTOH this seems to be "raw" value of something. So, I maybe missed the convention
in IIO about this kind of values WRT the variable types used on ABI side.

That said, I leave it to Jonathan since I'm not convinced that u16 is a proper
choice here.

> > > > > I can understand your reasoning but again this is something that I
> > > > > never really saw being enforced. So, I'm more than ok to change it if
> > > > > it really becomes something that we will try to "enforce" in IIO.
> > > > > Otherwise it just feels as a random nitpick :).
> > > > 
> > > > No, this is about consistency and common sense. If you define type uXX,
> > > > we have an API for that exact type. It's confusing why POD type APIs
> > > > are used with fixed-width types or vise versa.
> > > > 
> > > > Moreover (which is pure theoretical, though) some architectures might
> > > > have no (mutual) equivalency between these types.

-- 
With Best Regards,
Andy Shevchenko


