Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB92A431B
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 11:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKCKgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 05:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgKCKdp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:45 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2547206F1;
        Tue,  3 Nov 2020 10:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604399624;
        bh=Eg2L7GMc+D/grmQRd+uDIOy1N1FwECV5+z+rWhgWBGQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lpRPtrFVwYxL28XMFETMMxsPcUfVkgyNCQIQ8OpGteT5bulqB2GAnBJe7sO4JaVpX
         0JskbgnRi3JlwQPsrtXdRdaGSk8QE/dRmM6zZuwJkopHgHaFgOMy1Qxf2XX2EnpRGB
         OvlcPvCdlX4NoR2TrUxlUXgB3ngwvrirPz+DjiXg=
Date:   Tue, 3 Nov 2020 11:33:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Sandeep Singh <Sandeep.Singh@amd.com>,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com, andy.shevchenko@gmail.com,
        mail@richard-neumann.de, m.felsch@pengutronix.de,
        rdunlap@infradead.org, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v8 1/4] SFH: Add maintainers and documentation for AMD
 SFH based on HID framework
In-Reply-To: <alpine.DEB.2.21.2010300902220.16621@felia>
Message-ID: <nycvar.YFH.7.76.2011031133080.18859@cbobk.fhfr.pm>
References: <20201009200138.1847317-1-Sandeep.Singh@amd.com> <20201009200138.1847317-2-Sandeep.Singh@amd.com> <alpine.DEB.2.21.2010300902220.16621@felia>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Oct 2020, Lukas Bulwahn wrote:

> > From: Sandeep Singh <sandeep.singh@amd.com>
> > 
> > Add Maintainers for AMD SFH(SENSOR FUSION HUB) Solution and work flow
> > document.
> > 
> > Co-developed-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> > Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> > Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> > ---
> >  Documentation/hid/amd-sfh-hid.rst | 145 ++++++++++++++++++++++++++++++
> >  Documentation/hid/index.rst       |   1 +
> >  MAINTAINERS                       |   8 ++
> >  3 files changed, 154 insertions(+)
> >  create mode 100644 Documentation/hid/amd-sfh-hid.rst
> >
> 
> I do not know where something went wrong here, but it seems that
> the git commit 302f0dad8c97 ("SFH: Add maintainers and 
> documentation for AMD SFH based on HID framework") on next-20201030 
> dropped the addition of the rst file compared to this patch v8 here.

Thanks for spotting this, that was me fat-fingering conflict resolution. 
I've now pushed out a fix.

-- 
Jiri Kosina
SUSE Labs

