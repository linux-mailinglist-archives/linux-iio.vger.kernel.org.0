Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8D3A0F34
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 11:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhFIJDB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 05:03:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11292 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhFIJC7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 05:02:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1598tngo021330;
        Wed, 9 Jun 2021 08:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yxZ33z/ij2fUQhSTHogXfHEeZX6RxjggVDZ8OIpu7LI=;
 b=ZWVYoKxI73lvE2I6snU7+AToxrGwT/OKuq7+RNkbXJ0bzKokdLsW/mdbgGbOHsKmpeF8
 6hUa0q08UdMDYm9zI3K24Cs3M9Ra/HzZofgzlxS1Gc9kvWaNF4E/6sJXKj/rPDl0wh9x
 8islMhjpdhTDbqztkUsn70N8Rj1ZZ0T/0eAF4P8CfmJXAoj7Vwp2i/KW/2N9fxn8wsoX
 jnLUgzWwUkWBgB8zdiCEpo3FfFE/OqAwdv95ribMFa9iBWSwf12LnrdRoLYW7Lpmhzhj
 hbfhl1fY5eqByeg/jrtHVv6mQK8BIxMnp13lvGhBYJiRRhAxBn/51+hWoinj9aKDCKAk sw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 391g4g8w2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:59:55 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 1598v8fs066583;
        Wed, 9 Jun 2021 08:59:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 390k1rrkg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:59:54 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1598xreW077970;
        Wed, 9 Jun 2021 08:59:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 390k1rrkfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:59:53 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1598xmAk001991;
        Wed, 9 Jun 2021 08:59:48 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 08:59:47 +0000
Date:   Wed, 9 Jun 2021 11:59:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v11 26/33] counter: Add character device interface
Message-ID: <20210609085938.GM10983@kadam>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
 <2b9526ab7f2de91bb867cbd3b12552c77c00b655.1623201082.git.vilhelm.gray@gmail.com>
 <20210609080708.GL10983@kadam>
 <YMB7mq0LHqmyAAzb@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMB7mq0LHqmyAAzb@shinobu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: 4I8RCZTTf-Fxzs_HCqW4XL5igtPktEGw
X-Proofpoint-ORIG-GUID: 4I8RCZTTf-Fxzs_HCqW4XL5igtPktEGw
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 09, 2021 at 05:28:10PM +0900, William Breathitt Gray wrote:
> On Wed, Jun 09, 2021 at 11:07:08AM +0300, Dan Carpenter wrote:
> > On Wed, Jun 09, 2021 at 10:31:29AM +0900, William Breathitt Gray wrote:
> > > +static int counter_set_event_node(struct counter_device *const counter,
> > > +				  struct counter_watch *const watch,
> > > +				  const struct counter_comp_node *const cfg)
> > > +{
> > > +	struct counter_event_node *event_node;
> > > +	struct counter_comp_node *comp_node;
> > > +
> > 
> > The caller should be holding the counter->events_list_lock lock but it's
> > not.
> 
> Hi Dan,
> 
> The counter_set_event_node() function doesn't access or modify
> counter->events_list (it works on counter->next_events_list) so holding
> the counter->events_list_lock here isn't necessary.
> 

There needs to be some sort of locking or this function can race with
itself.  (Two threads add the same event at exactly the same time).  It
looks like it can also race with counter_disable_events() leading to a
use after free.

> > > +	/* Search for event in the list */
> > > +	list_for_each_entry(event_node, &counter->next_events_list, l)
> > > +		if (event_node->event == watch->event &&
> > > +		    event_node->channel == watch->channel)
> > > +			break;
> > > +
> > > +	/* If event is not already in the list */
> > > +	if (&event_node->l == &counter->next_events_list) {
> > > +		/* Allocate new event node */
> > > +		event_node = kmalloc(sizeof(*event_node), GFP_ATOMIC);

Btw, say we decided that we can add/remove events locklessly, then these
GFP_ATOMICs can be changed to GFP_KERNEL.

> > > +		if (!event_node)
> > > +			return -ENOMEM;
> > > +
> > > +		/* Configure event node and add to the list */
> > > +		event_node->event = watch->event;
> > > +		event_node->channel = watch->channel;
> > > +		INIT_LIST_HEAD(&event_node->comp_list);
> > > +		list_add(&event_node->l, &counter->next_events_list);
> > > +	}
> > > +
> > > +	/* Check if component watch has already been set before */
> > > +	list_for_each_entry(comp_node, &event_node->comp_list, l)
> > > +		if (comp_node->parent == cfg->parent &&
> > > +		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read)
> > > +			return -EINVAL;
> > > +
> > > +	/* Allocate component node */
> > > +	comp_node = kmalloc(sizeof(*comp_node), GFP_ATOMIC);
                                                ^^^^^^^^^^

> > > +	if (!comp_node) {
> > > +		/* Free event node if no one else is watching */
> > > +		if (list_empty(&event_node->comp_list)) {
> > > +			list_del(&event_node->l);
> > > +			kfree(event_node);
> > > +		}
> > > +		return -ENOMEM;
> > > +	}
> > > +	*comp_node = *cfg;
> > > +
> > > +	/* Add component node to event node */
> > > +	list_add_tail(&comp_node->l, &event_node->comp_list);
> > > +
> > > +	return 0;
> > > +}

regards,
dan carpenter

