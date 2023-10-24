Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860C7D564C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Oct 2023 17:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJXP2Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Oct 2023 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjJXP2Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Oct 2023 11:28:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F01731
        for <linux-iio@vger.kernel.org>; Tue, 24 Oct 2023 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Fc4bn544TwXhA3M2ue5d63axfXMECYTioIt9LX2YdOM=; b=bNpeeM8yKZObeEgSTjkHxTsEX8
        oMLNPsLPK+7d7MFh/mASX2C3NX2+dsgtxp4XtwmgkUGtPshMIP1NnXhmOcwltoiifzkLPdSrx8sAZ
        RGCAn0KZJtSkdIimJJ/5zHcuw3HBTr6UsGRQTG5/whcx2ATaqtuY2SLSnPH0eBwCdUsUUfYOx/Zw5
        8P2HDa8wRLsXfA9c1mjGqfGVUSJQUW5LdZsUszuLEiYqwaN8hoMvG7VS9veKKoNm0bHuACYuENsWR
        lx/Vj8dUZKUuXsloOVtyaDLL3jnqcHrtxANeVc3FryelDvRzWFviYe+ZFQyRG1DbHxZwIZE9DHnuW
        EId2pAlA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvJK4-003EhF-GW; Tue, 24 Oct 2023 15:28:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E25B300473; Tue, 24 Oct 2023 17:28:00 +0200 (CEST)
Date:   Tue, 24 Oct 2023 17:28:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
Message-ID: <20231024152800.GA13938@noisy.programming.kicks-ass.net>
References: <20231022154710.402590-1-jic23@kernel.org>
 <20231022154710.402590-2-jic23@kernel.org>
 <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
 <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
 <20231024151123.GB40044@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024151123.GB40044@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 24, 2023 at 05:11:23PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 23, 2023 at 10:55:56AM +0200, Nuno Sá wrote:
> 
> > > > +/*
> > > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > > + *
> > > > + *     CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> > > > + *     if (IS_ERR(claimed_dev))
> > > > + *             return PTR_ERR(claimed_dev);
> > > > + *
> > > > + *     st = iio_priv(claimed_dev);
> > > > + *     ....
> > > > + */
> > > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > > +            iio_device_release_direct_mode(_T),
> > > > +            ({
> > > > +                       struct iio_dev *dev;
> > > > +                       int d = iio_device_claim_direct_mode(_T);
> > > > +
> > > > +                       if (d < 0)
> > > > +                               dev = ERR_PTR(d);
> > > > +                       else
> > > > +                               dev = _T;
> > > > +                       dev;
> > > > +            }),
> > > > +            struct iio_dev *_T);
> > > > +
> 
> > I don't really have a very strong opinion on this but what I really don't like
> > much is the pattern:
> > 
> > CLASS(type, ret), where the return value is an argument of the macro... It would
> > be nice if we could just make it like:
> > 
> > ret = guard(type)(...); //or any other variation of the guard() macro
> > if (ret) 
> > 	return ret;
> > 
> > the above could also be an error pointer or even have one variation of each. but
> > yeah, that likely means changing the cleanup.h file and that might be out of
> > scope for Jonathan's patch series. 
> 
> So I have a version for trylocks that I've not managed to send out.. it
> doesn't deal with arbitrary error codes, and as someone else down-thread
> noted, the guard() thing is not really suited for tricks like this.
> 
> Notably I have a patch that converts ptrace_attach() to have a loop like:
> 
> 	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {
> 
> 		goto success;
> 	}
> 	return -ERESTARTNOINTR;
> 
> success:
> 	...
> 	return 0;
> 
> 
> And another patch that does something like:
> 
> 	scoped_cond_guard (rwsem_read_intr, no_lock,
> 			   task ? &task->signal->exec_update_lock : NULL) {
> 
> 		if (0) {
> no_lock:
> 			if (task)
> 				return -EINTR;
> 		}
> 		
> 		...
> 	}
> 

Hmm, looking at:

+       case IIO_CHAN_INFO_RAW: { /* magic value - channel value read */
+               CLASS(iio_claim_direct, claimed_dev)(indio_dev);
+               if (IS_ERR(claimed_dev))
+                       return PTR_ERR(claimed_dev);
+               guard(mutex)(&st->lock);
+
                switch (chan->type) {
                case IIO_VOLTAGE:
                        if (chan->output) {
                                /* Set integer part to cached value */
                                *val = st->dac_val;
+                               return IIO_VAL_INT;
                        } else if (chan->differential) {
                                if (chan->channel == 1)
                                        *val = st->differential_adc_val[0];
                                else
                                        *val = st->differential_adc_val[1];
+                               return IIO_VAL_INT;
                        } else {
                                *val = st->single_ended_adc_val;
+                               return IIO_VAL_INT;
                        }
+
                case IIO_ACCEL:
                        *val = st->accel_val;
+                       return IIO_VAL_INT;
                default:
+                       return -EINVAL;
                }
+       }


And your iio_device_claim_direct_mode(), that is basically a trylock,
either it succeeds (and returns 0) or fails with -EBUSY.

Which means you could write your thing above like:

DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
            iio_device_release_direct_mode(_T),
            ({
                       struct iio_dev *dev;
                       int d = iio_device_claim_direct_mode(_T);

                       if (d < 0)
                               dev = NULL;
                       else
                               dev = _T;
                       dev;
            }),
            struct iio_dev *_T);

static inline void *
class_iio_claim_direct_lock_ptr(class_iio_claim_direct_t *_T)
{ return *_T; }



	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
		scoped_guard (iio_device_claim, indio_dev) {
			guard(mutex)(&st->lock);
			switch (chan->type) {
			case ..:
				return IIO_VAL_INT;
			default:
				return -EINVAL;
			}
		}
		return -EBUSY;

and it would all just work, no?
