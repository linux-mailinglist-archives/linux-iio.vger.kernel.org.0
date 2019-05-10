Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C319A1A
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2019 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEJI51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 May 2019 04:57:27 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37487 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfEJI51 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 May 2019 04:57:27 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id BDA95240004;
        Fri, 10 May 2019 08:57:22 +0000 (UTC)
Message-ID: <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers
 to create a /dev/input interface
From:   Bastien Nocera <hadess@hadess.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Fri, 10 May 2019 10:57:22 +0200
In-Reply-To: <20190422152014.7c6637ab@archlinux>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
         <20190407133037.0ad98897@archlinux>
         <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
         <20190414124029.1f1f6084@archlinux>
         <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
         <20190422152014.7c6637ab@archlinux>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2019-04-22 at 15:20 +0100, Jonathan Cameron wrote:
> > Different goals usually lead to different solution architectures.
> 
> Indeed, but in this case we have your proposal which is a subset of
> what
> I am suggesting.  One architecture can fulfil both requirements.
> 
> I'll leave it for the other thread, but Bastien has raised the case
> (that I'd forgotten) that there already userspace stacks that are
> capable of happily taking in both IIO and Input devices.  The
> confusion
> here is they will now discover 'both' without the existing userspace
> knowing that they are the same device.  We need to be very careful
> not
> to break those userspace programs.
> 
> So this is an illustration of why the simplistic case doesn't work
> 'now'.

I don't know what state the whole patch is, but, at the very least, I'd
expect that patch to export the fact that it's exporting synthesised
data from another driver, so that it can be easily ignored in user-
space that already supports IIO devices.

