Return-Path: <linux-iio+bounces-17353-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D89A75AD0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D595A1889CA7
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C81D79BE;
	Sun, 30 Mar 2025 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd9BOLmb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20F9461;
	Sun, 30 Mar 2025 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743350881; cv=none; b=PHfLhot+71Eit3v8N25IuZn2m0ux1bEHGjcsGuRJjr4ahGRVjgnyNouHp+RC2PFT5eV5qKm3vY08O85ClPU7sXw1gO6BdBKjQxpVgV+yYajxJ5JjSCzswVZkl3ssjg/s0qH9OI3irBkexBtirigk20WxcjnrRg6xlc/IumaiS0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743350881; c=relaxed/simple;
	bh=H+MtWmTdkziBn0VV5vZW/5X6QRHEOhzJFpXEfO/uuYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPo2Z+IiVXMZKOK2MKH6HPC2KhyyPyAo+DVLD9ZNCK0sqES5SivNLakZ9c1+DQtJxxZ+VzKpBkOaAqy7ubEfHxjUBuGI200OjrWVtnkfpGlTHwnkKhwCx0LvPzggnFEPG9jXgY0WFF0a5Nl308bSO3VQuDFeUdN8KQxWbW94xJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd9BOLmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B76C4CEDD;
	Sun, 30 Mar 2025 16:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743350880;
	bh=H+MtWmTdkziBn0VV5vZW/5X6QRHEOhzJFpXEfO/uuYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vd9BOLmb075F+HnfLLGKxhbHRX0hJJX5BI4L04rjlF/64bkg3m4Je0iC8TADr+FMG
	 lldP4dFPVBrTUStmKGetqxwU7XftMHotWF96OvgidAZK7uGK4N+DvzFFE1g9sqEDxA
	 qsQAUE0QCAQq387ldy8hawwWgYdgNy23X4Ujt6UNiDRXj7j7dkkUyJa61ahuGhZZow
	 oPpJm8vFk/yMNn5cMZPC2F3rD4gLZvhB91ofA7oSc1zHm3Y6H7NiemTMnaAeztEKAa
	 FGPWGJvkbAvk8x6ioZ166CNp+81D53AO2keT4PDNRdmBffZwOIj/QooDczn7KGhrxe
	 fLSLvvo00EqUw==
Date: Sun, 30 Mar 2025 17:07:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v8 02/10] property: Add functions to iterate named child
Message-ID: <20250330170749.7fe553cd@jic23-huawei>
In-Reply-To: <726281b2-66f5-45e9-94f2-4f79b4ab159d@gmail.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
	<9c3880f74476436f39d796b5c10c540ae50b722c.1742225817.git.mazziesaccount@gmail.com>
	<Z9mQPJwnKAkPHriT@kekkonen.localdomain>
	<b6b62ddd-ab59-4112-8f6e-c72618c45910@gmail.com>
	<Z9rhfJUlCbi7kA2m@kekkonen.localdomain>
	<726281b2-66f5-45e9-94f2-4f79b4ab159d@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 08:43:44 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 19/03/2025 17:23, Sakari Ailus wrote:
> > On Wed, Mar 19, 2025 at 08:02:24AM +0200, Matti Vaittinen wrote:  
> >> On 18/03/2025 17:24, Sakari Ailus wrote:  
> >>> On Mon, Mar 17, 2025 at 05:50:38PM +0200, Matti Vaittinen wrote:  
> >>>> There are a few use-cases where child nodes with a specific name need to
> >>>> be parsed. Code like:  
> 
> ...
> 
> >>>> --- a/include/linux/property.h
> >>>> +++ b/include/linux/property.h
> >>>> @@ -167,10 +167,18 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
> >>>>    	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
> >>>>    	     child = fwnode_get_next_child_node(fwnode, child))
> >>>> +#define fwnode_for_each_named_child_node(fwnode, child, name)		\
> >>>> +	fwnode_for_each_child_node(fwnode, child)			\
> >>>> +		if (!fwnode_name_eq(child, name)) { } else
> >>>> +
> >>>>    #define fwnode_for_each_available_child_node(fwnode, child)		       \
> >>>>    	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
> >>>>    	     child = fwnode_get_next_available_child_node(fwnode, child))
> >>>> +#define fwnode_for_each_available_named_child_node(fwnode, child, name)	\
> >>>> +	fwnode_for_each_available_child_node(fwnode, child)		\
> >>>> +		if (!fwnode_name_eq(child, name)) { } else
> >>>> +  
> >>>
> >>> OF only enumerates available nodes via the fwnode API, software nodes don't
> >>> have the concept but on ACPI I guess you could have a difference in nodes
> >>> where you have device sub-nodes that aren't available. Still, these ACPI
> >>> device nodes don't have meaningful names in this context (they're
> >>> 4-character object names) so you wouldn't use them like this anyway.  
> >>
> >> I believe you have far better understanding on these concepts than I do. The
> >> reason behind adding fwnode_for_each_available_child_node() was the patch
> >> 10/10:
> >>
> >> -	fwnode_for_each_available_child_node(sensors, node) {
> >> -		if (fwnode_name_eq(node, "sensor")) {
> >> -			if (!thp7312_sensor_parse_dt(thp7312, node))
> >> -				num_sensors++;
> >> -		}
> >> +	fwnode_for_each_available_named_child_node(sensors, node, "sensor") {
> >> +		if (!thp7312_sensor_parse_dt(thp7312, node))
> >> +			num_sensors++;
> >>   	}
> >>
> >>  
> >>> So my question is: is it useful to provide this besides
> >>> fwnode_for_each_named_child_node(), given that both are effectively the
> >>> same?  
> >>
> >> So, I suppose you're saying the existing thp7312 -driver has no real reason
> >> to use the 'fwnode_for_each_available_child_node()', but it could be using
> >> fwnode_for_each_child_node() instead?
> >>
> >> If so, I am Ok with dropping the
> >> 'fwnode_for_each_available_named_child_node()' and changing the 10/10 to:
> >>
> >> -	fwnode_for_each_available_child_node(sensors, node) {
> >> -		if (fwnode_name_eq(node, "sensor")) {
> >> -			if (!thp7312_sensor_parse_dt(thp7312, node))
> >> -				num_sensors++;
> >> -		}
> >> +	fwnode_for_each_named_child_node(sensors, node, "sensor") {
> >> +		if (!thp7312_sensor_parse_dt(thp7312, node))
> >> +			num_sensors++;
> >>   	}
> >>
> >> Do you think that'd be correct?  
> > 
> > I'd say so. Feel free to cc me to the last patch as well.  
> 
> Thanks. I'll drop the fwnode_for_each_available_named_child_node() then.
> 
> > I guess one way to make this clearer is to switch to
> > fwnode_for_each_child_node() in a separate patch before
> > fwnode_for_each_named_child_node() conversion.  
> 
> I suppose this makes sense.

this _available_ thing is ancient history that has tripped us up
many times before. I've very keen to not see another case sneaking
in.  Whether we can definitely 'fix' all existing cases is a different
question..

> 
> I think this series can't make it to 6.15-rc1. Meaning, these 
> *_named_*() APIs perhaps land in 6.16-rc1. I assume these *_named_*() 
> APIs will go through the IIO. This rather simple IIO driver's review 
> took longer than I predicted, with more versions I intended (as always) 
> - and I kind of dislike respinning the whole series, with this large 
> audience, when changes are not interesting to the most.
> 
> Maybe it is simplest to drop the thp7312 (and gianfar) from this series, 
> and respin them only when the 6.16-rc1 is out. It's going to be couple 
> of months though - so there's always a risk that I forget.
> 
> The proposed change for the thp7312, from 
> fwnode_for_each_available_child_node() to fwnode_for_each_child_node() 
> can be done earlier though.
> 
> > There are also just a handful of users of
> > fwnode_for_each_available_child_node() and I guess these could be
> > converted, too, but I think it's outside the scope of the set.  
> 
> Definitely not in the scope of the bd79124 support :)
Agreed. Break this series up however you like and entirely up to
you whether you do further cleanup of other bits of the kernel!

Jonathan

> 
> Yours,
> 	-- Matti


