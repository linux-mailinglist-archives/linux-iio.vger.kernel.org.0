Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CCD4BEAF2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Feb 2022 20:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiBUSvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Feb 2022 13:51:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiBUSvH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Feb 2022 13:51:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24BA195;
        Mon, 21 Feb 2022 10:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645469443; x=1677005443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=48JzrGcTX6rVc7SRQV6pRltiPRSxLzqQcpIlYLCwjao=;
  b=VvG4yEpmFBDLiapwSRUysMSQMjdjEq35Rx7/4Dd0pS8SD0eG7n79CYzl
   JaAAUGfYuWcAltzXt+sbr1kUsCwn3v8feYSrTDzZ304fjBDGFVZTmKA3T
   41Kx5fhJDgFqa6EQuwf3ml8lYjIZuDTBgiA7GCYPr8fic7yTDobn4OEjv
   5dVoPua+WhOudTmjORCgVoMXdXzrlWgWip62auxZShVE9e/2MZGFJBmwq
   okBPd894VmoYkLVvHHil9Gv2exySIZqSu8nfacf928dcVLwcBf2EV+lTz
   zZ7arnTbEPFPo8sXuNqGbVHvjw+Xj3f01GnZIoKc9xZ5gLN3/xHgAHe6w
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251313809"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251313809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:50:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="505207399"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 10:50:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nMDkr-006sqq-2Y;
        Mon, 21 Feb 2022 20:49:49 +0200
Date:   Mon, 21 Feb 2022 20:49:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <YhPezO7CcDOAK/HU@smile.fi.intel.com>
References: <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YgD91zg4L1S5KH5k@smile.fi.intel.com>
 <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
 <Ygpd7pebiuGuB8nT@smile.fi.intel.com>
 <11bd63bc07fd406bfa31bdc38b597011cc9312cc.camel@gmail.com>
 <YhImsJidUu2fMKgu@smile.fi.intel.com>
 <3f2523127eb320a9825e272353afea9673e5d003.camel@gmail.com>
 <YhPGJqEuTQ3TBy46@smile.fi.intel.com>
 <20220221173045.00003969@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221173045.00003969@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 21, 2022 at 05:30:45PM +0000, Jonathan Cameron wrote:
> On Mon, 21 Feb 2022 19:04:38 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Feb 21, 2022 at 01:48:12PM +0100, Nuno Sá wrote:
> > > On Sun, 2022-02-20 at 13:32 +0200, Andy Shevchenko wrote:  
> > > > On Fri, Feb 18, 2022 at 02:51:28PM +0100, Nuno Sá wrote:  
> > > > > On Mon, 2022-02-14 at 15:49 +0200, Andy Shevchenko wrote:  
> > > > > > On Mon, Feb 07, 2022 at 09:19:46PM +0100, Nuno Sá wrote:  
> > > > > > > On Mon, 2022-02-07 at 13:09 +0200, Andy Shevchenko wrote:  
> > > > > > > > On Sun, Feb 06, 2022 at 01:19:59PM +0000, Sa, Nuno wrote:  
> > > > > > > > > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > > > > > > Sent: Saturday, February 5, 2022 6:30 PM
> > > > > > > > > > On Fri, Jan 21, 2022 at 03:24:59PM +0100, Nuno Sá wrote:  
> > 
> > ...
> > 
> > > > > > > > > > > +       ret = kstrtou16(buf, 10, &val);  
> > > > > > > > > > 
> > > > > > > > > > In other function you have long, here u16. I would expect that
> > > > > > > > > > the types are of the same class, e.g. if here you have u16,
> > > > > > > > > > then there something like s32 / s64.  Or here something like
> > > > > > > > > > unsigned short.
> > > > > > > > > > 
> > > > > > > > > > A bit of elaboration why u16 is chosen here?  
> > > > > > > > > 
> > > > > > > > > Well, I never really saw any enforcement here to be honest
> > > > > > > > > (rather than using stdint types...). So I pretty much just use
> > > > > > > > > these in unsigned types because I'm lazy and u16 is faster to
> > > > > > > > > type than unsigned short...  In this case, unless Jonathan really
> > > > > > > > > asks for it, I prefer not to go all over the driver and change
> > > > > > > > > this...  
> > > > > > > > 
> > > > > > > > This is about consistency. It may work as is, but it feels not good
> > > > > > > > when for int (or unsigned int) one uses fixed-width types. Also
> > > > > > > > it's non- written advice to use fixed-width variables when it's
> > > > > > > > about programming registers or so, for the rest, use POD types.  
> > > > > 
> > > > > Ok, going a bit back in the discussion, you argued that in one place I
> > > > > was using long while here u16. Well, in the place I'm using long, that
> > > > > was on purpose because that value is to be compared against an array of
> > > > > longs (which has to be long because it depends on CCF rates). I guess I
> > > > > can als0 use s64, but there is also a reason why long was used.
> > > > > 
> > > > > In the u16 case, we really want to have 2 bytes because I'm going to use
> > > > > that value to write the dac code which is 2 bytes.  
> > > > 
> > > > Okay, that's what I want to hear. If it's indeed goes to be a value to the
> > > > register, then it's fine.
> > > > 
> > > > Perhaps a comment?  
> > > 
> > > I guess you mean to have a comment to state that here we have fixed
> > > size type (as opposed to long, used in another place), because we
> > > directly use the value on a register write?
> > > 
> > > Asking it because I'm not planning to add comments in all the places
> > > where I have fixed size types for register read/writes...  
> > 
> > Thinking more about it and now I'm convinced that using the value that goes to
> > the register in ABI is bad idea (means that user space must not care about the
> > size or contents of the hardware register and should be abstract representation
> > of the HW).
> > 
> > OTOH this seems to be "raw" value of something. So, I maybe missed the convention
> > in IIO about this kind of values WRT the variable types used on ABI side.
> > 
> > That said, I leave it to Jonathan since I'm not convinced that u16 is a proper
> > choice here.
> 
> From a userspace point of view it doesn't care as it's writing a string.
> In this particular case the string only has valid values that from 0-(2^16-1)
> (i.e. 16 bits).  So if it writes outside of that range it is an error.
> You could read it into an unsigned long and then check against the range,
> but there is little point given you'd still return an error if it was out of
> range.  The fact that kstrto16() does that for you really just a shortcut
> though it will return -ERANGE rather than perhaps -EINVAL which might be used
> for a more generic "not this value".
> 
> Userspace can also read the range that is acceptable from
> out_voltage0_raw_available [0 1 2^16-1] and hence not write an invalid value
> in the first place - which is obviously preferred to getting an error.
> Scaling etc is also expressed to userspace so it it wants to write a particular
> voltage it can perform the appropriate scaling. Note that moving linear scaling
> like this to userspace allows easy use of floating point + may be a significant
> performance advantage if using the chrdev interface which uses the same
> approach (and values) as the sysfs interface.

With the same logic it can be unsigned short, no?

The point is to use u16 when it's indeed fixed-width value that goes to
hardware or being used as part of a protocol. And thus mentioning of the
IOCTL protocols may justify the choice. Then the question to the other
values, shouldn't they be also fixed-width ones?

> > > > > > > I can understand your reasoning but again this is something that I
> > > > > > > never really saw being enforced. So, I'm more than ok to change it if
> > > > > > > it really becomes something that we will try to "enforce" in IIO.
> > > > > > > Otherwise it just feels as a random nitpick :).  
> > > > > > 
> > > > > > No, this is about consistency and common sense. If you define type uXX,
> > > > > > we have an API for that exact type. It's confusing why POD type APIs
> > > > > > are used with fixed-width types or vise versa.
> > > > > > 
> > > > > > Moreover (which is pure theoretical, though) some architectures might
> > > > > > have no (mutual) equivalency between these types.  

-- 
With Best Regards,
Andy Shevchenko


