Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE9E3C5AC7
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 13:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhGLKWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 06:22:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3379 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhGLKWS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jul 2021 06:22:18 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GNfbt4Jx0z6GFRQ;
        Mon, 12 Jul 2021 18:08:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 12:19:28 +0200
Received: from localhost (10.47.25.8) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 12 Jul
 2021 11:19:27 +0100
Date:   Mon, 12 Jul 2021 11:19:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     David Lechner <david@lechnology.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@pengutronix.de>, <a.fatoum@pengutronix.de>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <alexandre.belloni@bootlin.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <syednwaris@gmail.com>,
        <patrick.havelange@essensium.com>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <o.rempel@pengutronix.de>, <jarkko.nikula@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v12 14/17] counter: Implement *_component_id sysfs
 attributes
Message-ID: <20210712111909.00004f72@Huawei.com>
In-Reply-To: <72d6513c-c7fc-c53d-b750-ebd2e8f3b848@lechnology.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
        <0e04a9e6455faf171e5dd7885676e55b5321b1ea.1625471640.git.vilhelm.gray@gmail.com>
        <bd0313ce-22fa-0516-93a1-ff3a5cb1fdd1@lechnology.com>
        <20210711142800.60e94cc7@jic23-huawei>
        <72d6513c-c7fc-c53d-b750-ebd2e8f3b848@lechnology.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.25.8]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Jul 2021 09:08:29 -0500
David Lechner <david@lechnology.com> wrote:

> On 7/11/21 8:28 AM, Jonathan Cameron wrote:
> > On Sat, 10 Jul 2021 12:06:53 -0500
> > David Lechner <david@lechnology.com> wrote:
> >   
> >> On 7/5/21 3:19 AM, William Breathitt Gray wrote:  
> >>> The Generic Counter chrdev interface expects users to supply component
> >>> IDs in order to select extensions for requests. In order for users to
> >>> know what component ID belongs to which extension this information must
> >>> be exposed. The *_component_id attribute provides a way for users to
> >>> discover what component ID belongs to which respective extension.
> >>>
> >>> Cc: David Lechner <david@lechnology.com>
> >>> Cc: Gwendal Grignou <gwendal@chromium.org>
> >>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> >>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >>> ---
> >>>    Documentation/ABI/testing/sysfs-bus-counter | 16 ++++++++++-
> >>>    drivers/counter/counter-sysfs.c             | 30 ++++++++++++++++-----
> >>>    2 files changed, 39 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> >>> index 9809d8a47431..e0e99adb0ecc 100644
> >>> --- a/Documentation/ABI/testing/sysfs-bus-counter
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> >>> @@ -203,12 +203,26 @@ Description:
> >>>    		both edges:
> >>>    			Any state transition.
> >>>    
> >>> +What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
> >>>    What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
> >>> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id  
> >>
> >> Could we just write a single line?
> >>
> >> What:		/sys/bus/counter/devices/counterX/signalY/<component>_component_id  
> > 
> > Not nice for grepping so I think it's better to call them out explicitly.
> > 
> > There has been a proposal to check this ABI doc against running kernels, and if we have
> > too many wild cards that becomes very difficult to do.
> > 
> > Jonathan
> >   
> >>  
> >>>    KernelVersion:	5.15  
> 
> Makes sense. Do we start a new group of similar names with the same
> description for each kernel release that includes new attributes then?

You've spotted one of the short comings of current format.  The scripts that
produce the html docs don't cope with multiple version numbers.

Mostly for IIO we've just been cynical and not had the correct kernel version for
new ABI when it's added. It's not ideal though.

The alternative, as you mention is to have a new block.  Perhaps we can have
that refer back to the existing one if the docs cover the new entries as well.

@Mauro:  Any suggestions for this?

Thanks

Jonathan


> 
> >>>    Contact:	linux-iio@vger.kernel.org
> >>>    Description:
> >>>    		Read-only attribute that indicates the component ID of the
> >>> -		respective Synapse of Count Y for Signal Z.
> >>> +		respective extension or Synapse.
> >>>      

