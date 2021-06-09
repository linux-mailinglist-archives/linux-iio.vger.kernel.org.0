Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5E3A0E81
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhFIIKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 04:10:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:44928 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236372AbhFIIKY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 04:10:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159816I3028665;
        Wed, 9 Jun 2021 08:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=NnLFLy6WiVANq4ptGMm8XdcANXjvh36YpOOiuo1dOgQ=;
 b=mAMgVxXKyBWt5WCOYIyPcZWO01FH2Jwe6e7G+c2ONOURttrX/UnoaeVTCJ2TvIfOsoGi
 EX6wUJFa8SzMbEDf5H6frysLFa+6wAEwft68o1we4l/7r/B39khQ+Eqwhig5hs24kaja
 V3axR98mIbLH5HgeYAz6vxZFrXsvgte09rch22M/Q7I/PyKNjB/d2jYazHlkHx0yfh2d
 udfJF2tzP8F0zdRGt7vkhMVCO98xjReUMF8nYtUy1cm1mcwh5FY9i8nPhx/kdPFjg6Zy
 4WhXz2k33qB3WnOjLGidhIHEc1lkzsiUODKXRDet1qmtff0E8L/ph2CwQw8m775d4hw0 Bg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 392ptc82c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:07:24 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15987NwI008371;
        Wed, 9 Jun 2021 08:07:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38yxcvf8dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:07:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15987MPF008350;
        Wed, 9 Jun 2021 08:07:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 38yxcvf8ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jun 2021 08:07:22 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15987I9a021286;
        Wed, 9 Jun 2021 08:07:19 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Jun 2021 01:07:18 -0700
Date:   Wed, 9 Jun 2021 11:07:08 +0300
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
Message-ID: <20210609080708.GL10983@kadam>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
 <2b9526ab7f2de91bb867cbd3b12552c77c00b655.1623201082.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b9526ab7f2de91bb867cbd3b12552c77c00b655.1623201082.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: iI8kgw7SjTD5aVufBK71XYzTdzproYAH
X-Proofpoint-GUID: iI8kgw7SjTD5aVufBK71XYzTdzproYAH
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 09, 2021 at 10:31:29AM +0900, William Breathitt Gray wrote:
> +static int counter_set_event_node(struct counter_device *const counter,
> +				  struct counter_watch *const watch,
> +				  const struct counter_comp_node *const cfg)
> +{
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +

The caller should be holding the counter->events_list_lock lock but it's
not.


> +	/* Search for event in the list */
> +	list_for_each_entry(event_node, &counter->next_events_list, l)
> +		if (event_node->event == watch->event &&
> +		    event_node->channel == watch->channel)
> +			break;
> +
> +	/* If event is not already in the list */
> +	if (&event_node->l == &counter->next_events_list) {
> +		/* Allocate new event node */
> +		event_node = kmalloc(sizeof(*event_node), GFP_ATOMIC);
> +		if (!event_node)
> +			return -ENOMEM;
> +
> +		/* Configure event node and add to the list */
> +		event_node->event = watch->event;
> +		event_node->channel = watch->channel;
> +		INIT_LIST_HEAD(&event_node->comp_list);
> +		list_add(&event_node->l, &counter->next_events_list);
> +	}
> +
> +	/* Check if component watch has already been set before */
> +	list_for_each_entry(comp_node, &event_node->comp_list, l)
> +		if (comp_node->parent == cfg->parent &&
> +		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read)
> +			return -EINVAL;
> +
> +	/* Allocate component node */
> +	comp_node = kmalloc(sizeof(*comp_node), GFP_ATOMIC);
> +	if (!comp_node) {
> +		/* Free event node if no one else is watching */
> +		if (list_empty(&event_node->comp_list)) {
> +			list_del(&event_node->l);
> +			kfree(event_node);
> +		}
> +		return -ENOMEM;
> +	}
> +	*comp_node = *cfg;
> +
> +	/* Add component node to event node */
> +	list_add_tail(&comp_node->l, &event_node->comp_list);
> +
> +	return 0;
> +}
> +
> +static int counter_disable_events(struct counter_device *const counter)
> +{
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&counter->events_list_lock, flags);
> +
> +	counter_events_list_free(&counter->events_list);
> +
> +	if (counter->ops->events_configure)
> +		err = counter->ops->events_configure(counter);
> +
> +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +
> +	counter_events_list_free(&counter->next_events_list);
> +
> +	return err;
> +}
> +
> +static int counter_add_watch(struct counter_device *const counter,
> +			     const unsigned long arg)
> +{
> +	void __user *const uwatch = (void __user *)arg;
> +	struct counter_watch watch;
> +	struct counter_comp_node comp_node = {0};

Always use = {};.  It's the new hotness, and it avoids a Sparse warning
for using 0 instead of NULL.  #IDidNotTest #CouldBeWrongAboutSparse

> +	size_t parent, id;
> +	struct counter_comp *ext;
> +	size_t num_ext;
> +	int err;
> +

regards,
dan carpenter

