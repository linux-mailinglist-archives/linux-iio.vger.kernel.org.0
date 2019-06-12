Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F78421D7
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfFLJ6V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 05:58:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44848 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfFLJ6V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 05:58:21 -0400
Received: from laptop-1.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8517E260D5E;
        Wed, 12 Jun 2019 10:58:19 +0100 (BST)
Message-ID: <46f153d21d91cdc910a074864ac92fce7f9c76b7.camel@collabora.com>
Subject: Re: [PATCH v2 1/3] iio: common: cros_ec_sensors: support protocol
 v3 message
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     kernel@collabora.com, Nick Vaccaro <nvaccaro@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 12 Jun 2019 11:58:16 +0200
In-Reply-To: <20190612084243.GC4797@dell>
References: <cover.1558601329.git.fabien.lahoudere@collabora.com>
         <b619ce4f7f2d10ce1ede2b99d7262828f5b24952.1558601329.git.fabien.lahoudere@collabora.com>
         <20190612084243.GC4797@dell>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Le mercredi 12 juin 2019 à 09:42 +0100, Lee Jones a écrit :
> On Thu, 23 May 2019, Fabien Lahoudere wrote:
> 
> > Version 3 of the EC protocol provides min and max frequencies and
> > fifo
> > size for EC sensors.
> > 
> > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> > ---
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 83
> > ++++++++++++++++++-
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  4 +
> >  include/linux/mfd/cros_ec_commands.h          | 21 +++++
> 
> There have been many changes to this file recently.  We will have to
> co-ordinate the merge.
> 
> But for now:
> 
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 

Yes I see the changes and my next submission will use recent patch and
drop my modification in cros_ec_commands.h.

Thanks for reviewing


