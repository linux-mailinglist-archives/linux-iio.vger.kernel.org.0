Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B173755CE
	for <lists+linux-iio@lfdr.de>; Thu,  6 May 2021 16:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhEFOoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 May 2021 10:44:05 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:37036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234694AbhEFOoE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 May 2021 10:44:04 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 10:44:04 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 37BAF1802EFEA
        for <linux-iio@vger.kernel.org>; Thu,  6 May 2021 14:38:03 +0000 (UTC)
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 90136837F24D;
        Thu,  6 May 2021 14:38:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 0BA2D315D7E;
        Thu,  6 May 2021 14:37:59 +0000 (UTC)
Message-ID: <eb9aaace58730082253eae3c577136bb05ac82af.camel@perches.com>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Date:   Thu, 06 May 2021 07:37:57 -0700
In-Reply-To: <CAHp75VdHMm+WYA2Nfiz1g3B5Sj14Rq601aSyQ_puynudg9ZiZw@mail.gmail.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
         <CAHp75Vd0N5s=D9LFiVU75gYCLnpqOwfBogbWUTwZNC1CV2n88Q@mail.gmail.com>
         <20210506133754.GA2266661@roeck-us.net>
         <768c06ff-663c-eacb-fd3c-628b4e4ba449@redhat.com>
         <20210506135052.GB2267050@roeck-us.net>
         <CAHp75VdHMm+WYA2Nfiz1g3B5Sj14Rq601aSyQ_puynudg9ZiZw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0BA2D315D7E
X-Spam-Status: No, score=-1.40
X-Stat-Signature: yo563xmp4spdra4zn3aae81u3dobfoqz
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX182Giu6DFmaWMRG+A0W1UqK5an6K6kEKB0=
X-HE-Tag: 1620311879-858103
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2021-05-06 at 17:31 +0300, Andy Shevchenko wrote:
> On Thu, May 6, 2021 at 4:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Thu, May 06, 2021 at 03:42:08PM +0200, Hans de Goede wrote:
> > > On 5/6/21 3:37 PM, Guenter Roeck wrote:
> 
> ...
> 
> > > We (mostly Andy and me) are not even 100% sure this one is
> > > a fake ACPI ID, but we do pretty strongly believe that it is.
> > > 
> > 
> > What a mess :-(
> 
> What we can do is a checkpatch-alike check for vendor ID to be
> registered in [1] and issue a warning if not. At least it alerts
> maintainers. Joe, do you think it is doable or we should have a
> separate tool for that? (Because I have no clue how checkpatch
> cohabits with internet connection, otherwise the problem with
> synchronisation of that registry might be a problem)

Perhaps best to have a separate scriptable tool and if necessary
have checkpatch use it like the spdxcheck block.

scripts/checkpatch.pl-sub is_SPDX_License_valid {
scripts/checkpatch.pl-  my ($license) = @_;
scripts/checkpatch.pl-
scripts/checkpatch.pl:  return 1 if (!$tree || which("python") eq "" || !(-e "$root/scripts/spdxcheck.py") || !(-e "$gitroot"));
scripts/checkpatch.pl-
scripts/checkpatch.pl-  my $root_path = abs_path($root);
scripts/checkpatch.pl:  my $status = `cd "$root_path"; echo "$license" | python scripts/spdxcheck.py -`;
scripts/checkpatch.pl-  return 0 if ($status ne "");
scripts/checkpatch.pl-  return 1;
scripts/checkpatch.pl-}

[]

scripts/checkpatch.pl-                          } elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
scripts/checkpatch.pl-                                  my $spdx_license = $1;
scripts/checkpatch.pl:                                  if (!is_SPDX_License_valid($spdx_license)) {
scripts/checkpatch.pl-                                          WARN("SPDX_LICENSE_TAG",
scripts/checkpatch.pl-                                               "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
scripts/checkpatch.pl-                                  }


