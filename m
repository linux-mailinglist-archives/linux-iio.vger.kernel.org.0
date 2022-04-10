Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658614FAF47
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiDJRWq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiDJRWk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 13:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124C443F7
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 10:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9709D61172
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 17:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C17C385A1;
        Sun, 10 Apr 2022 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649611228;
        bh=eh6c7H2laol+ytlItUpL3/vVVKDhSsVwgy+0YoSb7rU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M69DbxxHgwYh47cQjke9swPUM1N1MNwXMusKda8tllbC9bXzqeIRI0vDR2Yh183e5
         N7Gb69+yl9R+RrBu/zZrqPXRuiyUJ/I0C25zdEth+UNwHNK1J9PzSfShTRTTY+XhZG
         lJXGqyIMGjjoJPf0L0dW2rNjhn5fehLwzNWdB3du1NHA3eo3Egc0SXRNSIVmP3No/B
         vtm0hMlJcZW2zMgGLKkuXXW9OosqWXQJPJuHuayAV3Jvzo6tdt168ZMs9Jsmy1/qv9
         1yt8LBXfUo0GHtGlrnDo3mbCincWGMVvnWpVLiwavLKcbL8mn2gWy7Xq7vXJA7+2nK
         5U9mHSY19zZKQ==
Date:   Sun, 10 Apr 2022 18:28:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com
Subject: Re: GSoC Proposal 2022
Message-ID: <20220410182819.23967855@jic23-huawei>
In-Reply-To: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Apr 2022 00:23:29 -0300
Ma=C3=ADra Canal <maira.canal@usp.br> wrote:

> Hi everyone, I am Ma=C3=ADra Canal an undergrad student at the University
> of S=C3=A3o Paulo, Brazil, pursuing
> computer engineering. I wish to participate in the GSoC 2021 as a part
> of the Linux Foundation, IIO Project.

Hi Ma=C3=ADra,

Nice to 'meet' you ;)

>=20
> I have been contributing to the Linux kernel for a couple of months
> and have more than 20
> accepted patches in a couple of subsystems.
>=20
> I started looking through the catalog of Analog Devices Inc. and I'm
> pretty interested in writing a driver for gyroscopes, inertial
> measurement units (IMUs), magnetometers, pressure sensors, proximity
> sensors, or temperature sensors. But, while looking through the
> catalog, I could not figure out a sensor that would be relevant to
> Linux Kernel. I mean, I would like to work on a sensor that would be
> relevant to the community and to Analog Devices Inc.
>=20
> In that sense, I would like to know if anyone in the IIO community
> could recommend a sensor that would make sense for the company and the
> IIO community. Any suggestion is appreciated!

I'm not going to recommend a particular sensor, but more offer some general
tips on what 'sort' of device makes a good target for a GSOC.
Finding a sensor means trawling datasheets and I'm tight on time today
+ I've no real insight into what the ADI folk might like to see
supported!

The nature of a GSOC driver submission is often a little different to
how an experienced driver author might go about things, simply because you
will / should be looking for feedback at more stages of development and
hopefully to upstream things in multiple stages.  An old hand at IIO
drivers will often just jump directly to a driver supporting all the
features they wish to target.  As such, the 'perfect' device to target
should meet a few requirements that may not be true for the approach of jum=
ping
straight to the end goal.  Note this is equally true for other people
starting out writing drivers - though they can often do very simple
devices first and that is not a good plan for a GSOC project where
you need to have a progression during the project.

Try to find something that offers some advanced features to provide
stretch goals but make sure the basic functionality will work with
a much simpler driver. So devices that provide straight forward
registers to access the latest channel value are great, whereas
those that only offer a streaming interfaces / fifo may be less suitable.
However if they offer both that is perfect as the fifo make a good
later feature for a GSOC project if things are going particularly
well!  For a real stretch goal, find a device with features that
we don't support at all today (perhaps new sensor types, or some
other new feature) as they'll give you the experience of defining
new ABI + possibly modifying the IIO core to meet some requirements.

Another thing to look at it is whether the part is sufficiently
different from those supported by existing drivers to justify a
separate driver. If not, you may find your GSOC project becomes
simply adding an ID! (then rapidly choosing a second device to
work on).

Hope that provides a few hints on what to look at.  Probably the best
way around is to suggest one or more parts you think look interesting
then we can give feedback on whether we think they'd be a good choice
or not.

Good luck!

Jonathan



>=20
> Sincerely,
> Ma=C3=ADra Canal

