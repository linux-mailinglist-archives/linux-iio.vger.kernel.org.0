Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E51C3662
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 12:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEDKCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 06:02:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47793 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEDKCl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 06:02:41 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D89A020007;
        Mon,  4 May 2020 10:02:37 +0000 (UTC)
Message-ID: <f69735176608713ce0c8458915aa4fb7ec833b90.camel@hadess.net>
Subject: Re: [PATCH v2] iio: st_sensors: make scale channels also shared by
 type
From:   Bastien Nocera <hadess@hadess.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?ISO-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>,
        linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Denis Ciocca <denis.ciocca@st.com>
Date:   Mon, 04 May 2020 12:02:36 +0200
In-Reply-To: <20200502190751.53123be3@archlinux>
References: <20200423121714.607262-1-rvlander@gaetanandre.eu>
         <20200425181359.1e30e315@archlinux>
         <faf0bf3315c93fddee4f4cdb890bc5e80701c8fd.camel@hadess.net>
         <20200502190751.53123be3@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2020-05-02 at 19:07 +0100, Jonathan Cameron wrote:
> On Sun, 26 Apr 2020 13:19:09 +0200
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Sat, 2020-04-25 at 18:13 +0100, Jonathan Cameron wrote:
> > > On Thu, 23 Apr 2020 14:17:15 +0200
> > > Gaëtan André <rvlander@gaetanandre.eu> wrote:
> > >   
> > > > Scale channels are available by axis. For example for
> > > > accelerometers,
> > > > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are
> > > > available.
> > > > 
> > > > However, they should be shared by type as documented in
> > > > Documentation/ABI/testing/sysfs-bus-iio.
> > > > 
> > > > For each sensor (acceleros, gyros and magnetos) only one value
> > > > is
> > > > specified
> > > > for all the axes.
> > > > 
> > > > Existing, by axis, entries are preserved in order to to leave
> > > > the
> > > > old ABI
> > > > untouched.  
> > > As I mentioned in v1, there isn't a strict ABI rule that says
> > > that we
> > > must
> > > do the shared form
> > > 
> > > +CC'd Bastien for comment on what userspace is assuming and
> > > whether
> > > we should
> > > push this back to stable or not.  
> > 
> > I have no idea what the effects of this would be on the ABI, and
> > how
> > this would impact iio-sensor-proxy.
> 
> There goes me being lazy ;)
> 
> > Code is here though, so it might be best to test it:
> > https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/tree/master/src
> > 
> > And we accept merge requests :)
> 
> Only looks at scale and in_accel_scale
> 
> Easy enough to fix...
> 
> Note that for some older accelerometers it has to do per channel
> scales btw.
> It used to be hard to have the same range out of the plane of the
> silicon
> than within it, so was common to have sensors with different ranges
> and hence
> scales in z direction from x and y.
> 
> I'll apply the kernel patch but good to fix up iio-sensor-proxy as
> well.
> 
> I would ideally like Denis to give this a quick sanity check though
> as I'd
> like to give it a stable tag and don't want any unexpected breakage.

I've made this:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/306
which should work just fine for the sensors which have a trigger (the z
scaling was the one applied to all 3 axes).

What's the name of the file that contains the x/y/z axis scale
information for devices without triggers?

Cheers

