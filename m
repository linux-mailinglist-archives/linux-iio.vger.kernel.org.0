Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9967366
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 18:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGLQem (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 12:34:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51288 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfGLQem (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 12:34:42 -0400
Received: from pc-381.home (2a01cb0c80061e00e835b5cf688fec09.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:8006:1e00:e835:b5cf:688f:ec09])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 04013274268;
        Fri, 12 Jul 2019 17:34:39 +0100 (BST)
Date:   Fri, 12 Jul 2019 18:34:36 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: Re: [PATCH v4 2/3] i3c: move i3c_device_match_id to device.c and
 export it
Message-ID: <20190712183436.1b3d3cf5@pc-381.home>
In-Reply-To: <SN6PR12MB265549866115B706616C2081AEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
        <debadccffef84c541601a97162ac656cd7c58478.1562931742.git.vitor.soares@synopsys.com>
        <20190712180338.47b50e9f@linux.home>
        <SN6PR12MB265549866115B706616C2081AEF20@SN6PR12MB2655.namprd12.prod.outlook.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Jul 2019 16:21:49 +0000
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> > 
> > You're missing a kerneldoc here.  
> 
> I will do that. Can you clarify why we need that?
> 

So the function is properly documented here [1].

> >   
> > > +const struct i3c_device_id *
> > > +i3c_device_match_id(struct i3c_device *i3cdev,
> > > +		    const struct i3c_device_id *id_table)
> > > +{
> > > +	struct i3c_device_info devinfo;
> > > +	const struct i3c_device_id *id;
> > > +
> > > +	i3c_device_get_info(i3cdev, &devinfo);
> > > +
> > > +	/*
> > > +	 * The lower 32bits of the provisional ID is just filled with a random
> > > +	 * value, try to match using DCR info.
> > > +	 */
> > > +	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> > > +		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
> > > +		u16 part = I3C_PID_PART_ID(devinfo.pid);
> > > +		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
> > > +
> > > +		/* First try to match by manufacturer/part ID. */
> > > +		for (id = id_table; id->match_flags != 0; id++) {
> > > +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> > > +			    I3C_MATCH_MANUF_AND_PART)
> > > +				continue;
> > > +
> > > +			if (manuf != id->manuf_id || part != id->part_id)
> > > +				continue;
> > > +
> > > +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> > > +			    ext_info != id->extra_info)
> > > +				continue;
> > > +
> > > +			return id;
> > > +		}
> > > +	}
> > > +
> > > +	/* Fallback to DCR match. */
> > > +	for (id = id_table; id->match_flags != 0; id++) {
> > > +		if ((id->match_flags & I3C_MATCH_DCR) &&
> > > +		    id->dcr == devinfo.dcr)
> > > +			return id;
> > > +	}
> > > +
> > > +	return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(i3c_device_match_id);
> > > +


[1]https://www.kernel.org/doc/html/latest/driver-api/i3c/device-driver-api.html
