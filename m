Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D9714DCB
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEFOy4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 10:54:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:27605 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfEFOqZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 May 2019 10:46:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 07:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="343985669"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2019 07:46:21 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hNesm-0006d2-HJ; Mon, 06 May 2019 17:46:20 +0300
Date:   Mon, 6 May 2019 17:46:20 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Message-ID: <20190506144620.GM9224@smile.fi.intel.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
 <20190422210606.GA8805@kroah.com>
 <86ea407aaa891e50a3bdaf2c3653636a365076ee.camel@analog.com>
 <20190424133455.00002909@huawei.com>
 <20190425193736.GA11458@kroah.com>
 <CA+U=DsoyPQyNDX6CDx=xE73H9A=66BGKhTseEvZcZZPnpPAfQw@mail.gmail.com>
 <20190426142754.GU9224@smile.fi.intel.com>
 <CA+U=DspC2gbcWgEoCfTs-K0UaGt9DBLkXoyFufShUXD61uAAbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DspC2gbcWgEoCfTs-K0UaGt9DBLkXoyFufShUXD61uAAbQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 06, 2019 at 04:45:43PM +0300, Alexandru Ardelean wrote:
> On Fri, Apr 26, 2019 at 5:27 PM andriy.shevchenko@linux.intel.com
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 12:29:11PM +0300, Alexandru Ardelean wrote:
> >
> > > Hmm, I actually did not give much thought to that -1.
> > > I'll check into this and see about a V3.
> > > It may make more sense to just fix the original
> > > `__sysfs_match_string()`, but I'll need to go through the users of
> > > this function and see.
> >
> > I was thinking about existing users of such (with "gaps") cases.
> > Not all of them have NULL there and would like to avoid some members.
> > Though, I think that we may ignore NULL items if -1 is supplied.
> >
> > Think as well about ARRAY_SIZE() as given to that.
> >
> 
> I am a bit vague on what you are proposing.
> Is it:
> 
> a) Leave __sysfs_match_string() as-is and introduce a new
> `__sysfs_match_string_with_gaps()` helper/variant ?
> b) Fix __sysfs_match_string() to break/exit on the first NULL, only if
> -1 is provided ?
> 
> Either is fine, but I wanted to clarify.

The current logic something like "-1 to go till first NULL" and ARRAY_SIZE() in
*some* cases is basically the synonym to above.

What I meant is to check if there is *any* case where ARRAY_SIZE() behaves in
the same way as -1. Those cases should be fixed accordingly.

Otherwise, the b) is what would be preferred according to the discussion.

> > And consider to fix match_string() accordingly.

-- 
With Best Regards,
Andy Shevchenko


