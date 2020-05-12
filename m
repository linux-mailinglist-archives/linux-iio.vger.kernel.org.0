Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F051CF68D
	for <lists+linux-iio@lfdr.de>; Tue, 12 May 2020 16:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgELOLl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 May 2020 10:11:41 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:38725 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgELOLl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 May 2020 10:11:41 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 953DA20008;
        Tue, 12 May 2020 14:11:37 +0000 (UTC)
Message-ID: <a2082a0448f87f69fceb3629f6d33a9b51a77948.camel@hadess.net>
Subject: Re: [PATCH v2] iio: st_sensors: make scale channels also shared by
 type
From:   Bastien Nocera <hadess@hadess.net>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        =?ISO-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>,
        linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Denis Ciocca <denis.ciocca@st.com>
Date:   Tue, 12 May 2020 16:11:36 +0200
In-Reply-To: <20200504112220.00007be1@Huawei.com>
References: <20200423121714.607262-1-rvlander@gaetanandre.eu>
         <20200425181359.1e30e315@archlinux>
         <faf0bf3315c93fddee4f4cdb890bc5e80701c8fd.camel@hadess.net>
         <20200502190751.53123be3@archlinux>
         <f69735176608713ce0c8458915aa4fb7ec833b90.camel@hadess.net>
         <20200504112220.00007be1@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2020-05-04 at 11:22 +0100, Jonathan Cameron wrote:
> 
<snip>
> For both devices with triggers and without, if they are per axis they
> should be
> in_accel_x_scale
> in_accel_y_scale
> in_accel_z_scale
> 
> hmm. It's not in our ABI docs for accel channels (but is for
> magnetometers).
> Should fix that...
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-iio#L340
> 
> In theory the other combinations you can get are
> 
> in_accel_scale
> in_scale
> scale
> 
> The in scale one tends not to make much sense for accelerometers
> though so I would
> hope there are no instances of that in the wild (none in mainline).
> Shared by direction attributes are tend to apply for things like
> sampling frequency,
> not scale.

FYI, I merged:
https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requests/306

Let me know if I got it wrong.

